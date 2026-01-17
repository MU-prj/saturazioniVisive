# Versione minimale corretta
import cv2 as cv
import numpy as np
import random

img = cv.imread("dataset/images/IMG_6082.jpg")
h, w = img.shape[:2]
nFrags = 100

# Dividi in frammenti di dimensioni corrette
larghezze = []
for i in range(nFrags):
    # Distribuisci i pixel extra tra i primi frammenti
    larghezza = w // nFrags + (1 if i < w % nFrags else 0)
    larghezze.append(larghezza)

# Estrai i frammenti
frammenti = []
colonna = 0
for larghezza in larghezze:
    frammenti.append(img[:, colonna:colonna+larghezza])
    colonna += larghezza

# Mescola
random.shuffle(frammenti)

# Ricostruisci
nuova_img = np.zeros((h, w, 3), dtype=np.uint8)
colonna = 0
for frammento in frammenti:
    larghezza = frammento.shape[1]
    nuova_img[:, colonna:colonna+larghezza] = frammento
    colonna += larghezza

cv.imwrite("output/risultato_corretto.jpg", nuova_img)