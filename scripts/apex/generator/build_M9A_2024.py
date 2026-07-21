# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9A 2024 (1. řádný termín, skenované PDF)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2024_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2024, 1. řádný termín (M9A)"
CCODE = "M9PAD24C0T01"
YR = 2024
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2024 M9A · úloha 1", pts=1, mins=2, diff="3",
    zad=[r"Pět švadlen splní danou zakázku za $24$ hodin (pracují stejným tempem). Za jakou dobu splní o polovinu větší zakázku čtyři švadleny?"],
    solp=[r"Práce na zakázku $=5\cdot24=120$ švadlenohodin; o polovinu větší zakázka $=180$ švadlenohodin.",
          r"Čtyři švadleny: $\frac{180}{4}=45$ hodin."],
    ans=r"$45$ hodin",
    codes=["zs2", "r9", "aritmetika", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"Skleněné těžítko má tvar rotačního válce s poloměrem podstavy $10\ \mathrm{cm}$ a výškou $12\ \mathrm{cm}$. Uvnitř je část z modrého skla, také tvaru válce, s poloměrem podstavy $5\ \mathrm{cm}$ a výškou $8\ \mathrm{cm}$ (viz obrázek). Vnější část je z čirého skla.",
         r"Vypočítejte objem čirého skla v těžítku (zaokrouhlete na desítky $\mathrm{cm}^3$, $\pi\doteq3{,}14$)."],
    solp=[r"Objem těžítka $\pi\cdot10^2\cdot12=1\,200\pi\ \mathrm{cm}^3$; objem modrého skla $\pi\cdot5^2\cdot8=200\pi\ \mathrm{cm}^3$.",
          r"Čiré sklo $1\,000\pi\doteq3\,140\ \mathrm{cm}^3$."],
    ans=r"$3\,140\ \mathrm{cm}^3$",
    svg=fig(2, (148, 322, 432, 452)), fn=FN,
    alt="Skleněné těžítko tvaru válce (poloměr 10 cm, výška 12 cm) s vnitřním modrým válcem (poloměr 5 cm, výška 8 cm).",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 3", pts=4, mins=5, diff="3",
    zad=[r"Vypočítejte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(2:\dfrac{3}{2}\right):\dfrac{1}{2}+\left(\dfrac{5}{6}:\dfrac{3}{4}\right):\dfrac{2}{3}=$",
         r"3.2 \quad $\dfrac{\frac{13}{10}-1{,}4}{\frac{2}{15}+\frac{1}{6}}=$"],
    solp=[r"3.1: $\left(\frac{4}{3}\right):\frac{1}{2}+\left(\frac{10}{9}\right):\frac{2}{3}=\frac{8}{3}+\frac{5}{3}=\frac{13}{3}$.",
          r"3.2: čitatel $\frac{13}{10}-1{,}4=-\frac{1}{10}$; jmenovatel $\frac{2}{15}+\frac{1}{6}=\frac{3}{10}$; $-\frac{1}{10}:\frac{3}{10}=-\frac{1}{3}$."],
    ans=r"3.1: $\frac{13}{3}$; 3.2: $-\frac{1}{3}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Zjednodušte (bez závorek): $\left(a-\dfrac{a}{4}\right)^2=$",
         r"4.2 Rozložte na součin podle vzorce: $9a^2-16=$",
         r"4.3 Zjednodušte a rozložte na součin vytýkáním: $(c-5)\cdot(2-3c)-(c-2c)\cdot3c-c\cdot7=$"],
    solp=[r"4.1: $\left(\frac{3a}{4}\right)^2=\frac{9a^2}{16}$.",
          r"4.2: $9a^2-16=(3a-4)(3a+4)$.",
          r"4.3: $(-3c^2+17c-10)+3c^2-7c=10c-10=10(c-1)$."],
    ans=r"4.1: $\frac{9a^2}{16}$; 4.2: $(3a-4)(3a+4)$; 4.3: $10(c-1)$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte rovnice.",
         r"5.1 \quad $-2\cdot(x+4)-3\cdot(x+1)^2=x\cdot(2-3x)$",
         r"5.2 \quad $6-\dfrac{3-2y}{5}\cdot2=4y$"],
    solp=[r"5.1: $-2x-8-3(x^2+2x+1)=2x-3x^2\Rightarrow -3x^2-8x-11=2x-3x^2\Rightarrow -11=10x\Rightarrow x=-1{,}1$.",
          r"5.2: vynásobením $5$: $30-2(3-2y)=20y\Rightarrow 24+4y=20y\Rightarrow 24=16y\Rightarrow y=\frac{3}{2}$."],
    ans=r"5.1: $x=-1{,}1$; 5.2: $y=\frac{3}{2}$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 6", pts=4, mins=5, diff="4",
    zad=[r"Pravoúhlý lichoběžník $ABCD$ se základnami $AB$ a $CD$ má pravý úhel při vrcholu $B$. Základna $AB$ má délku $40\ \mathrm{cm}$, základna $CD$ délku $28\ \mathrm{cm}$ a úhlopříčka $AC$ délku $41\ \mathrm{cm}$ (viz obrázek).",
         r"6.1 Vypočítejte obsah lichoběžníku $ABCD$ (v $\mathrm{cm}^2$).",
         r"6.2 Vypočítejte délku ramene $AD$ (v cm)."],
    solp=[r"V pravoúhlém trojúhelníku $ABC$ (pravý úhel u $B$): $BC=\sqrt{AC^2-AB^2}=\sqrt{41^2-40^2}=9\ \mathrm{cm}$ (výška lichoběžníku).",
          r"6.1: $S=\frac{40+28}{2}\cdot9=306\ \mathrm{cm}^2$.",
          r"6.2: vodorovný rozdíl základen je $40-28=12\ \mathrm{cm}$; $AD=\sqrt{12^2+9^2}=\sqrt{225}=15\ \mathrm{cm}$."],
    ans=r"6.1: $306\ \mathrm{cm}^2$; 6.2: $15\ \mathrm{cm}$",
    svg=fig(5, (280, 92, 592, 196)), fn=FN,
    alt="Pravoúhlý lichoběžník ABCD se základnami AB=40 cm, CD=28 cm, úhlopříčkou AC=41 cm a pravým úhlem při vrcholu B.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 7", pts=4, mins=5, diff="4",
    zad=[r"Žáci třídy 8. B se dělí na dvě stejně velké skupiny podle toho, zda chodí na němčinu, nebo na angličtinu. Ve třídě je $14$ chlapců a $5$ z nich chodí na angličtinu. Na němčinu chodí $4$ dívky.",
         r"7.1 Kolik dívek celkem chodí na angličtinu?",
         r"7.2 Kolik má třída 8. B celkem žáků?"],
    solp=[r"Skupina němčiny: $9$ chlapců $+4$ dívky $=13$ žáků; obě skupiny jsou stejně velké, tedy každá $13$ žáků, celkem $26$ žáků.",
          r"7.1: skupina angličtiny má $13$ žáků, z toho $5$ chlapců, tedy $8$ dívek.",
          r"7.2: celkem $26$ žáků."],
    ans=r"7.1: $8$ dívek; 7.2: $26$ žáků",
    codes=["zs2", "r9", "aritmetika", "argumentace", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 8", pts=4, mins=5, diff="4",
    zad=[r"Šedý obrazec je ohraničen vodorovnou úsečkou délky $20\ \mathrm{cm}$ (nahoře) a dvěma shodnými čtvrtkružnicemi o poloměru $10\ \mathrm{cm}$, které se dotýkají uprostřed dole (obrazec je vepsán do obdélníku $20\ \mathrm{cm}\times10\ \mathrm{cm}$).",
         r"8.1 Vypočítejte obsah šedého obrazce (v $\mathrm{cm}^2$, zaokrouhlete na celé $\mathrm{cm}^2$, $\pi\doteq3{,}14$).",
         r"8.2 Vypočítejte obvod šedého obrazce (v cm, zaokrouhlete na celé cm)."],
    solp=[r"8.1: obsah $=$ obdélník $-$ dvě čtvrtkružnice $=20\cdot10-\frac{1}{2}\pi\cdot10^2=200-157=43\ \mathrm{cm}^2$.",
          r"8.2: obvod $=$ úsečka $20\ \mathrm{cm}+2$ čtvrtkruhové oblouky $=20+2\cdot\frac{1}{4}\cdot2\pi\cdot10\doteq20+31{,}4=51\ \mathrm{cm}$."],
    ans=r"8.1: $43\ \mathrm{cm}^2$; 8.2: $51\ \mathrm{cm}$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $C$ a $S$. Bod $C$ je vrchol rovnostranného trojúhelníku $ABC$, bod $S$ je středem strany $AB$ (viz obrázek).",
         r"Sestrojte vrcholy $A$, $B$ rovnostranného trojúhelníku $ABC$ a trojúhelník narýsujte."],
    solp=[r"Úsečka $CS$ je výška (i těžnice) rovnostranného trojúhelníku, kolmá k $AB$; strana $AB$ prochází bodem $S$ kolmo k $CS$.",
          r"Ve rovnostranném trojúhelníku platí $|AS|=|SB|=\frac{|CS|}{\sqrt{3}}$; vrcholy $A$, $B$ naneseme na přímku $AB$ symetricky kolem $S$."],
    ans=r"Přímka $AB\perp CS$ prochází bodem $S$; vrcholy $A$, $B$ jsou symetricky kolem $S$ ve vzdálenosti $\frac{|CS|}{\sqrt{3}}$ (rovnostranný trojúhelník).",
    svg=fig(7, (66, 88, 595, 470)), fn=FN,
    alt="Body C a S v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží přímka $AE$ a přímka $p$ procházející bodem $E$. Bod $A$ je vrchol obdélníku $ABCD$, vrchol $B$ leží na přímce $AE$ a vrchol $C$ na přímce $p$. Úhlopříčka $BD$ má stejnou délku jako úsečka $AE$ (viz obrázek).",
         r"Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je a obdélník narýsujte."],
    solp=[r"Úhlopříčky obdélníku jsou stejně dlouhé a půlí se; $|BD|=|AC|=|AE|$.",
          r"Kružnice se středem $A$ a poloměrem $|AE|$ protne přímku $p$ ve vrcholu $C$; kolmice a rovnoběžky pak určí $B$ na přímce $AE$ a vrchol $D$."],
    ans=r"Kružnice $(A,|AE|)$ protne přímku $p$ ve vrcholu $C$; $B$ leží na $AE$, $D$ doplníme jako obdélník (viz konstrukce).",
    svg=fig(8, (66, 88, 595, 560)), fn=FN,
    alt="Přímka AE a přímka p procházející bodem E.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 11", pts=2, mins=4, diff="4",
    zad=[r"Přímky $p$, $q$, $r$ se protínají a jejich průsečíky tvoří vrcholy trojúhelníku $ABC$. Jsou dány úhly $\beta=23^\circ$ (vnitřní úhel při vrcholu $B$) a $\delta=107^\circ$ (vnější úhel při vrcholu $A$ na přímce $q$).",
         r"Jaká je velikost rozdílu úhlů $\gamma-\alpha$? (Velikosti neměřte, ale vypočítejte.)"],
    opts=[r"A) $10^\circ$", r"B) $11^\circ$", r"C) $12^\circ$", r"D) $13^\circ$", r"E) jiná velikost"],
    solp=[r"Vnitřní úhel při $A$: $\alpha=180^\circ-\delta=73^\circ$. Vnitřní úhel při $C$: $\gamma=180^\circ-\alpha-\beta=180^\circ-73^\circ-23^\circ=84^\circ$.",
          r"$\gamma-\alpha=84^\circ-73^\circ=11^\circ$."],
    ans=r"B) $11^\circ$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Obrazec (ve tvaru pětiúhelníku) je možné rozstříhat na $7$ shodných rovnoramenných trojúhelníků. Obvod jednoho takového trojúhelníku je $30\ \mathrm{cm}$.",
         r"Jaký je obvod celého obrazce?"],
    opts=[r"A) $55\ \mathrm{cm}$", r"B) $60\ \mathrm{cm}$", r"C) $66\ \mathrm{cm}$", r"D) $72\ \mathrm{cm}$", r"E) $90\ \mathrm{cm}$"],
    solp=[r"Rovnoramenný trojúhelník má ramena délky $a$ a základnu $b$, obvod $2a+b=30\ \mathrm{cm}$; z rozměrů obrazce vychází $a=12\ \mathrm{cm}$, $b=6\ \mathrm{cm}$.",
          r"Obvod pětiúhelníku tvoří vnější strany trojúhelníků; jejich součet je $66\ \mathrm{cm}$."],
    ans=r"C) $66\ \mathrm{cm}$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Máme dva shodné čtverce A a B. Čtverec A je (svislými řezy) rozdělen na dva shodné obdélníky, čtverec B na pět shodných obdélníků. Obvod jednoho obdélníku ve čtverci A je o $6\ \mathrm{cm}$ větší než obvod jednoho obdélníku ve čtverci B.",
         r"Jaký je obvod jednoho ze čtverců A nebo B?"],
    opts=[r"A) $40\ \mathrm{cm}$", r"B) $72\ \mathrm{cm}$", r"C) $80\ \mathrm{cm}$", r"D) $96\ \mathrm{cm}$", r"E) $128\ \mathrm{cm}$"],
    solp=[r"Strana čtverce $s$. Obdélník v A má obvod $2\left(s+\frac{s}{2}\right)=3s$, v B $2\left(s+\frac{s}{5}\right)=\frac{12}{5}s$.",
          r"Rozdíl $3s-\frac{12}{5}s=\frac{3}{5}s=6\Rightarrow s=10\ \mathrm{cm}$; obvod čtverce $4s=40\ \mathrm{cm}$."],
    ans=r"A) $40\ \mathrm{cm}$",
    codes=["zs2", "r9", "geometrie", "planimetrie", "rovnice", "argumentace", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Vynásobíme-li neznámé číslo dvěma a od výsledku odečteme $135$, získáme polovinu neznámého čísla. Jaká je hodnota neznámého čísla?"],
    opts=[r"A) $270$", r"B) $170$", r"C) $135$", r"D) $90$", r"E) jiný výsledek"],
    solp=[r"$2x-135=\frac{x}{2}\Rightarrow 2x-\frac{x}{2}=135\Rightarrow \frac{3}{2}x=135\Rightarrow x=90$."],
    ans=r"D) $90$",
    codes=["zs2", "r9", "rovnice", "slovni", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 15", pts=3, mins=5, diff="3",
    zad=[r"Půdorys domu má tvar obdélníku. Šířka domu je $10\ \mathrm{m}$, v plánu je vyznačena úsečkou délky $10\ \mathrm{cm}$. Délka domu je v plánu zakreslena jako úsečka délky $2\ \mathrm{dm}$.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"15.1 Měřítko plánu je $1:1\,000$.",
         r"15.2 Skutečná délka domu je $20\ \mathrm{m}$.",
         r"15.3 Obsah obdélníku na plánu a obsah půdorysu domu jsou v poměru $1:100$."],
    solp=[r"Šířka $10\ \mathrm{m}=1\,000\ \mathrm{cm}$ je v plánu $10\ \mathrm{cm}$, měřítko $1:100$.",
          r"15.1: měřítko je $1:100$, nikoli $1:1\,000$ — N.",
          r"15.2: délka v plánu $2\ \mathrm{dm}=20\ \mathrm{cm}$, skutečná $20\cdot100=2\,000\ \mathrm{cm}=20\ \mathrm{m}$ — A.",
          r"15.3: obsahy jsou v poměru $1:100^2=1:10\,000$, nikoli $1:100$ — N."],
    ans=r"15.1: N; 15.2: A; 15.3: N",
    codes=["zs2", "r9", "pomer", "geometrie", "argumentace", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2024 M9A · úloha 16", pts=6, mins=6, diff="3",
    zad=[r"Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).",
         r"16.1 Pan Novák si vypůjčil $20\,000$ Kč na jeden rok. Po roce vrátí vypůjčenou částku a navíc úrok $13{,}5\ \%$ z vypůjčené částky. Kolik korun celkem věřiteli vrátí?",
         r"16.2 Paní Dlouhá vložila $1\,000\,000$ Kč s roční úrokovou sazbou $2{,}5\ \%$; výnosy z úroků jsou zdaněny $15\ \%$. Kolik korun získá navíc ke svému vkladu za jeden rok?",
         r"16.3 Kolo stálo $20\,000$ Kč, nejdříve bylo zlevněno o $10\ \%$ z původní ceny, po měsíci zdraženo o $10\ \%$ z nové ceny. Jaká byla výsledná cena?"],
    opts=[r"A) $22\,700$ Kč", r"B) $21\,350$ Kč", r"C) $21\,250$ Kč", r"D) $20\,000$ Kč", r"E) $19\,800$ Kč", r"F) jiný výsledek"],
    solp=[r"16.1: $20\,000\cdot1{,}135=22\,700$ Kč — A.",
          r"16.2: úrok $25\,000$ Kč, po zdanění $25\,000\cdot0{,}85=21\,250$ Kč — C.",
          r"16.3: $20\,000\cdot0{,}9=18\,000$, poté $18\,000\cdot1{,}1=19\,800$ Kč — E."],
    ans=r"16.1: A ($22\,700$ Kč); 16.2: C ($21\,250$ Kč); 16.3: E ($19\,800$ Kč)",
    codes=["zs2", "r9", "procenta", "finance", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2024")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
