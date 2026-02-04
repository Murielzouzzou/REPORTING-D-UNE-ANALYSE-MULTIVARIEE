library(dplyr)
library(stringi)
library(FactoMineR)
library(factoextra)
library(missMDA)
library(corrplot)

setwd("C:/Users/murie/Downloads")

# Import des données
base <- read.csv("base final.csv", sep = ";", header = TRUE, stringsAsFactors = FALSE)
espe_vie <- read.csv("esperance-de-vie-par-regions.csv", header = TRUE, sep = ",")
pop6074 <- read.csv("pop60_74ans.csv", header = TRUE, sep = ";", encoding = "UTF-8")
jeunes1529 <- read.csv("jeunesfrance.csv", header = TRUE, sep = ";")

# Nettoyer codgeo dans base
base$codgeo <- base$COM

# Nettoyer codgeo dans jeunes1529
jeunes1529$codgeo <- jeunes1529$CODGEO

# Calculer proportion jeunes (15-29 ans)
jeunes1529 <- jeunes1529 %>%
  mutate(prop_15_29 = P21_POP1529 / P21_POP)

# Fusion base avec jeunes1529 pour ajouter prop_15_29
base_joined <- base %>%
  left_join(select(jeunes1529, codgeo, prop_15_29), by = "codgeo")

# Nettoyer noms régions pour fusion espérance de vie
base_joined$Region_clean <- stri_trans_general(base_joined$Région, "Latin-ASCII")
espe_vie$Region_clean <- stri_trans_general(espe_vie$Région, "Latin-ASCII")

# Joindre espérance de vie par région
base_joined <- base_joined %>%
  left_join(select(espe_vie, Region_clean, L.espérance.de.vie), by = "Region_clean")

# Préparer pop 60-74 ans dernière année
pop6074_latest <- pop6074 %>%
  group_by(codgeo) %>%
  filter(an == max(an)) %>%
  ungroup() %>%
  select(codgeo, pop6074)

# Fusion avec base_joined
base_joined <- base_joined %>%
  left_join(pop6074_latest, by = "codgeo")

# Calculer prop 60-74 ans
base_joined$prop_60_74 <- base_joined$pop6074 / base_joined$PTOT


# --- Analyse exploratoire des variables sport et santé ---

vars_sante <- c("Médecin.généraliste", "Masseur.kinésithérapeute", 
                "Pédicure.podologue", "Diététicien")
vars_sport_ext <- c("Boulodrome", "Tennis", "Athlétisme", 
                    "Plateaux.et.terrains.de.jeux.extérieurs", 
                    "Terrains.de.grands.jeux")
vars_sport_int <- c("Salles.spécialisées", "Salles.de.combat", 
                    "Salles.de.remise.en.forme", "Salles.multisports..gymnase.")

vars_acp <- c(vars_sante, vars_sport_ext, vars_sport_int)

# Extraire données variables sport et santé et convertir en numérique
data_acp_raw <- base_joined[, vars_acp]
data_acp_num <- data.frame(lapply(data_acp_raw, function(x) as.numeric(as.character(x))))

# Résumé statistique simple
print(summary(data_acp_num))

# Histogrammes des variables
par(mfrow = c(3,5)) # grille 3x5 (ajuster si nécessaire)
for (var in vars_acp) {
  hist(data_acp_num[[var]], main = paste("Histogramme de", var), xlab = var, col = "lightblue", breaks = 20)
}
par(mfrow = c(1,1)) # reset layout

# Matrice de corrélation
cor_mat <- cor(data_acp_num, use = "pairwise.complete.obs")

# Affichage matrice de corrélation
corrplot(cor_mat, method = "color", type = "upper", 
         tl.col = "black", tl.srt = 45, addCoef.col = "black", number.cex=0.7,
         title = "Matrice de corrélation des variables sport et santé", mar=c(0,0,1,0))


# --- Préparation et PCA (sans variables supplémentaires) ---

# Imputation si besoin
if(sum(is.na(data_acp_num)) > 0){
  ncp_est <- estim_ncpPCA(data_acp_num, ncp.max = 5)
  data_acp_imputed <- imputePCA(data_acp_num, ncp = ncp_est$ncp)$completeObs
} else {
  data_acp_imputed <- data_acp_num
}

# Standardiser les données
data_acp_scaled <- scale(data_acp_imputed)

# Réaliser PCA
res_pca <- PCA(data_acp_scaled, graph = FALSE)
res_pca$eig
res_pca$var$coord
res_pca$var$cos2
res_pca$var$contrib
# Affichage variance expliquée
print(res_pca$eig)

# Cercle des corrélations
fviz_pca_var(res_pca,
             col.var = "contrib",
             gradient.cols = c("blue", "purple", "red"),
             repel = TRUE,
             title = "Cercle de corrélation - Variables sport et santé")

# Projection des communes
fviz_pca_ind(res_pca,
             geom.ind = "point",
             col.ind = "cos2",
             gradient.cols = c("blue", "purple", "red"),
             repel = TRUE,
             title = "Projection des communes")






# avec suppppppppppppp




# 1. Imputer données actives si nécessaire
if (sum(is.na(data_acp_num)) > 0) {
  ncp_est <- estim_ncpPCA(data_acp_num, ncp.max = 5)
  data_acp_imputed <- imputePCA(data_acp_num, ncp = ncp_est$ncp)$completeObs
} else {
  data_acp_imputed <- data_acp_num
}
vars_supp <- base_joined[, c("prop_15_29", "prop_60_74")]
View(base_joined)
# 2. Imputer variables supplémentaires si nécessaire
if (sum(is.na(vars_supp)) > 0) {
  ncp_est_supp <- estim_ncpPCA(vars_supp, ncp.max = 2)
  vars_supp_imputed <- imputePCA(vars_supp, ncp = ncp_est_supp$ncp)$completeObs
} else {
  vars_supp_imputed <- vars_supp
}

# 3. Standardisation
data_acp_scaled <- scale(data_acp_imputed)
vars_supp_scaled <- scale(vars_supp_imputed)

# 4. Combinaison des données
data_combined <- cbind(data_acp_scaled, vars_supp_scaled)
nb_actives <- ncol(data_acp_scaled)
quanti_sup_indices <- (nb_actives + 1):(nb_actives + 2)

# 5. PCA avec variables supplémentaires
res_pca <- PCA(data_combined, quanti.sup = quanti_sup_indices, graph = FALSE)



#result : 
# Coordonnées sur les axes
res_pca$quanti.sup$coord

# Qualité de représentation
res_pca$quanti.sup$cos2

# Contributions aux axes (non utilisées pour calcul)
res_pca$quanti.sup$contrib
