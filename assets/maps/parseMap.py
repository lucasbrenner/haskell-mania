file_name = raw_input("Nome do arquivo: ")

title = ""
artist = ""
level = ""
stacks = []
notes = []

with open(file_name, "r") as f:
    startNotes = False
    for line in f.readlines():
        if startNotes:
            note = []
            values = line.split(",")

            note.append(int(values[2]))
            note.append(int(values[0]))

            if not int(values[0]) in stacks:
                stacks.append(int(values[0]))

            note.append(values[3] == "128") # eh um slider?
            if note[-1]:
                note.append(int(values[5].split(":")[0]))
            else:
                note.append(int(values[2]))

            notes.append(note)
        else:
            if line.startswith("Version:"):
                level = line.split(":")[-1]
            elif line.startswith("Title:"):
                title = line.split(":")[-1]
            elif line.startswith("Artist:"):
                artist = line.split(":")[-1]
            elif line.startswith("[HitObjects]"):
                startNotes = True

stacks.sort()

for i in range(len(notes)):
    for j in range(len(stacks)):
        if notes[i][1] == stacks[j]:
            notes[i][1] = j

    notes[i] = map(str, notes[i])
    notes[i] = " ".join(notes[i])

with open(file_name.replace(".osu", ".hmania"), "w") as f:
    f.write(title)
    f.write(artist)
    f.write(level)
    for line in notes:
        f.write(line)
        f.write("\n")
