import csv
import sys, ctypes as ct

csv.field_size_limit(int(ct.c_ulong(-1).value // 2))
arrValues=[]
with open('steam_reviews.csv', newline='', encoding='utf-8') as csvFile:
    tsvFile = open("tsvSteam.txt", mode="w", encoding='utf-8')
    archivoQl = csv.reader(csvFile, delimiter=',', quotechar='"')
    for row in archivoQl:
        row.pop(5)
        tsvFile.write('\t'.join(row))
        tsvFile.write('\n')
    tsvFile.close()
