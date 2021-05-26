map = open("AKITO_-_Sakura_Kagetsu_ZZHBOY_easy.hmania", "r")

texto = map.readlines()

dic = {}
novaLista = []

for i in range(0,len(texto)):
    var = texto[i].split(' ')
    var.pop()
    var.pop()
    for j in range(0,len(var)):
        if(j == 0):
            var[j] = (int(var[j]))//40
        var[j] = int(var[j])
    if(var[0] not in dic):
        novaLista.append(var)
        dic[var[0]] = 1
    

mapParsed = open("AKITO_-_Sakura_Kagetsu_ZZHBOY_easy.pmania", "w")
mapParsed.write(str(novaLista[:110]))

map.close()
mapParsed.close()
