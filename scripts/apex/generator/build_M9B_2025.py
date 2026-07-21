# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2025 (2. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2025_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2025, 2. řádný termín (M9B)"
CCODE = "M9PBD25C0T02"
YR = 2025
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []
P.append(dict(
    name="CERMAT 2025 M9B · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Cena dětské vstupenky do muzea je rovna dvěma pětinám ceny vstupenky pro dospělého. Jeden dospělý se třemi dětmi zaplatil za vstupenky $330$ korun.",
         r"Vypočtěte v korunách cenu jedné dětské vstupenky."],
    solp=[r"Nechť je cena dospělé vstupenky $d$; dětská je $\frac{2}{5}d$.",
          r"$d+3\cdot\frac{2}{5}d=\frac{11}{5}d=330\Rightarrow d=150$; dětská $\frac{2}{5}\cdot150=60$ korun."],
    ans=r"$60$ korun",
    codes=["zs2", "r9", "zlomky", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 2", pts=1, mins=2, diff="3",
    zad=[r"Vypočtěte druhou odmocninu ze součinu smíšených čísel $6\tfrac{1}{4}$ a $2\tfrac{7}{9}$. Výsledek zapište zlomkem v základním tvaru."],
    solp=[r"$6\tfrac{1}{4}=\frac{25}{4}$, $2\tfrac{7}{9}=\frac{25}{9}$; součin $\frac{625}{36}$.",
          r"$\sqrt{\frac{625}{36}}=\frac{25}{6}$."],
    ans=r"$\frac{25}{6}$",
    codes=["zs2", "r9", "zlomky", "mocniny-odmocniny", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 3", pts=3, mins=5, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{11}{5}-\dfrac{11}{6}\right):\left(-\dfrac{1}{3}\right)=$",
         r"3.2 \quad $\dfrac{20-\sqrt{4\cdot3^2}}{3\cdot\sqrt{100-64}}:\dfrac{4+3}{4\cdot3}=$"],
    solp=[r"3.1: $\frac{11}{5}-\frac{11}{6}=\frac{66-55}{30}=\frac{11}{30}$; $\frac{11}{30}:\left(-\frac{1}{3}\right)=-\frac{11}{10}$.",
          r"3.2: $\frac{20-\sqrt{36}}{3\sqrt{36}}=\frac{14}{18}=\frac{7}{9}$; $\frac{4+3}{4\cdot3}=\frac{7}{12}$; $\frac{7}{9}:\frac{7}{12}=\frac{12}{9}=\frac{4}{3}$."],
    ans=r"3.1: $-\frac{11}{10}$; 3.2: $\frac{4}{3}$",
    codes=["zs2", "r9", "zlomky", "mocniny-odmocniny", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 4", pts=4, mins=5, diff="3",
    zad=[r"4.1 Upravte na co nejjednodušší tvar bez závorek: $x\cdot3x-2x\cdot3-(x-3)^2=$",
         r"4.2 Upravte a výsledný výraz rozložte na součin vytknutím: $(2k)^2-k\cdot(1+2k)=$",
         r"4.3 Upravte na co nejjednodušší tvar bez závorek: $7a\cdot(a+3)+2\cdot(1-3a)\cdot(a+5)=$"],
    solp=[r"4.1: $3x^2-6x-(x^2-6x+9)=3x^2-6x-x^2+6x-9=2x^2-9$.",
          r"4.2: $4k^2-k-2k^2=2k^2-k=k\cdot(2k-1)$.",
          r"4.3: $7a^2+21a+2(-3a^2-14a+5)=7a^2+21a-6a^2-28a+10=a^2-7a+10$."],
    ans=r"4.1: $2x^2-9$; 4.2: $k\cdot(2k-1)$; 4.3: $a^2-7a+10$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 5", pts=4, mins=6, diff="3",
    zad=[r"Řešte:",
         r"5.1 \quad $\dfrac{7}{12}x+2\cdot\left(\dfrac{3}{8}x-1\right)=-3\cdot\left(\dfrac{x}{9}+1\right)$",
         r"5.2 \quad soustavu rovnic $\begin{aligned}6x+y&=14\\ 3x+2y&=1\end{aligned}$"],
    solp=[r"5.1: $\frac{7}{12}x+\frac{3}{4}x-2=-\frac{x}{3}-3$; vynásobením $12$: $7x+9x-24=-4x-36\Rightarrow 20x=-12\Rightarrow x=-\frac{3}{5}$.",
          r"5.2: z první $y=14-6x$; $3x+2(14-6x)=1\Rightarrow -9x=-27\Rightarrow x=3$, $y=-4$."],
    ans=r"5.1: $x=-\frac{3}{5}$; 5.2: $x=3$, $y=-4$",
    codes=["zs2", "r9", "rovnice", "linearni-rovnice", "soustava", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 6", pts=3, mins=4, diff="2",
    zad=[r"Číslo $231$ lze rozložit na součin tří prvočísel $a\cdot b\cdot c$.",
         r"6.1 Určete nejmenší z prvočísel $a$, $b$, $c$.",
         r"6.2 Určete součet všech tří prvočísel $a+b+c$.",
         r"6.3 Určete největší dvojciferné číslo, které je dělitelem čísla $231$."],
    solp=[r"$231=3\cdot7\cdot11$.",
          r"6.1: nejmenší prvočíslo je $3$.",
          r"6.2: $3+7+11=21$.",
          r"6.3: dělitelé $231$ jsou $1,3,7,11,21,33,77,231$; největší dvojciferný je $77$."],
    ans=r"6.1: $3$; 6.2: $21$; 6.3: $77$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 7", pts=4, mins=6, diff="3",
    zad=[r"Farmář prodával saláty za jednotnou cenu za kus a během tří dnů je všechny prodal. První den prodal třetinu všech salátů, druhý den o třetinu méně salátů než první den a třetí den zbytek.",
         r"7.1 Za všechny saláty utržil celkem $5\,400$ korun. Vypočtěte, kolik korun utržil za saláty prodané druhý den.",
         r"7.2 Počet všech prodaných salátů označíme $x$. Vyjádřete výrazem, kolik salátů prodal druhý den.",
         r"7.3 Třetí den prodal $120$ salátů. Určete počet všech prodaných salátů."],
    solp=[r"První den $\frac{1}{3}x$, druhý den o třetinu méně, tj. $\frac{2}{3}\cdot\frac{1}{3}x=\frac{2}{9}x$, třetí den zbytek $x-\frac{1}{3}x-\frac{2}{9}x=\frac{4}{9}x$.",
          r"7.1: druhý den $\frac{2}{9}$ tržby $=\frac{2}{9}\cdot5\,400=1\,200$ korun.",
          r"7.2: $\frac{2}{9}x$ salátů.",
          r"7.3: $\frac{4}{9}x=120\Rightarrow x=270$ salátů."],
    ans=r"7.1: $1\,200$ korun; 7.2: $\frac{2}{9}x$; 7.3: $270$ salátů",
    codes=["zs2", "r9", "zlomky", "rovnice", "slovni", "modelovani", "s-kalkulackou", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 8", pts=4, mins=6, diff="4",
    zad=[r"Velký pravoúhlý lichoběžník (rozměry na obrázku vlevo: rovnoběžné strany $100\ \mathrm{cm}$ a $140\ \mathrm{cm}$, výška $30\ \mathrm{cm}$) jsme jednou úsečkou rozdělili na menší lichoběžník a rovnoběžník (obrázek vpravo). Oba nové útvary mají stejný obvod.",
         r"8.1 Vypočtěte v $\mathrm{cm}^2$ obsah velkého pravoúhlého lichoběžníku.",
         r"8.2 Vypočtěte v cm obvod velkého pravoúhlého lichoběžníku.",
         r"8.3 Vypočtěte v cm obvod rovnoběžníku."],
    solp=[r"8.1: $S=\frac{100+140}{2}\cdot30=3\,600\ \mathrm{cm}^2$.",
          r"8.2: šikmé rameno $\sqrt{(140-100)^2+30^2}=\sqrt{2500}=50\ \mathrm{cm}$; obvod $140+100+30+50=320\ \mathrm{cm}$.",
          r"8.3: řez rovnoběžný se šikmým ramenem; rovnoběžník má strany $50$ a $55\ \mathrm{cm}$, obvod $2\cdot(50+55)=210\ \mathrm{cm}$."],
    ans=r"8.1: $3\,600\ \mathrm{cm}^2$; 8.2: $320\ \mathrm{cm}$; 8.3: $210\ \mathrm{cm}$",
    svg=fig(4, (75, 110, 560, 190)), fn=FN,
    alt="Velký pravoúhlý lichoběžník (strany 100 a 140 cm, výška 30 cm) a jeho rozdělení úsečkou na menší lichoběžník a rovnoběžník.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $B$, $M$ (viz obrázek).",
         r"Body $A$, $B$ jsou vrcholy rovnoramenného trojúhelníku $ABC$. Bod $M$ je uvnitř tohoto trojúhelníku a leží na těžnici $t_c$ na stranu $AB$ (bod $M$ není těžištěm).",
         r"Sestrojte vrchol $C$ trojúhelníku $ABC$, označte ho a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Rovnoramenný trojúhelník s ramenem $AB$? Nikoli — základna je $AB$ a těžnice $t_c$ z vrcholu $C$ prochází středem $AB$ a je kolmá k $AB$ (osa strany $AB$).",
          r"Vrchol $C$ leží na ose úsečky $AB$; navíc na přímce dané středem $AB$ a bodem $M$ (těžnice $t_c$ prochází $M$).",
          r"Osa $AB$ a přímka $t_c$ (střed $AB$ přes $M$) splývají; vrchol $C$ leží na této ose na obě strany od $AB$ — dvě řešení."],
    ans=r"Vrchol $C$ leží na ose strany $AB$, na přímce procházející středem $AB$ a bodem $M$ (dvě řešení).",
    svg=fig(5, (62, 64, 595, 360)), fn=FN,
    alt="Body A, B, M v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $A$, $D$, $M$ (viz obrázek).",
         r"Body $A$, $D$ jsou vrcholy rovnoběžníku $ABCD$. Na polopřímce $DM$ leží jedna z úhlopříček rovnoběžníku. Druhá úhlopříčka má stejnou délku jako úsečka $DM$.",
         r"Sestrojte vrcholy $B$, $C$ rovnoběžníku $ABCD$, označte je a rovnoběžník narýsujte."],
    solp=[r"Úhlopříčky rovnoběžníku se půlí; jejich průsečík $S$ je střed obou úhlopříček. Úhlopříčka $DB$ leží na polopřímce $DM$.",
          r"Druhá úhlopříčka $AC$ má délku $|DM|$, takže $|AS|=\frac{|DM|}{2}$; bod $C$ je obraz $A$ podle středu $S$.",
          r"Střed $S$ leží na polopřímce $DM$ tak, aby $|AS|=\frac{|DM|}{2}$; pak $B$ je obraz $D$ podle $S$ a $C$ obraz $A$ podle $S$."],
    ans=r"Průsečík úhlopříček $S$ leží na polopřímce $DM$ s $|AS|=\tfrac{|DM|}{2}$; $B$ je obraz $D$ a $C$ obraz $A$ ve středové souměrnosti podle $S$.",
    svg=fig(6, (62, 64, 595, 360)), fn=FN,
    alt="Body A, D, M v rovině.", cap="",
    codes=["zs2", "r9", "konstrukce", "geometrie", "planimetrie", "konstrukcni", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 11", pts=4, mins=5, diff="3",
    zad=[r"V zahradě se pěstuje $6$ druhů rostlin; diagram udává, jakou část osázené plochy zabírá každý druh. Magnolie zabírají $20\ \mathrm{m}^2$. U některých výsečí je uvedena velikost úhlu.",
         r"Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):",
         r"11.1 Jabloně zabírají o $15\ \mathrm{m}^2$ větší plochu než magnolie.",
         r"11.2 Levandule a bazalka dohromady zabírají $1{,}5$krát větší plochu než hortenzie.",
         r"11.3 Růže zabírají plochu menší než $30\ \mathrm{m}^2$."],
    solp=[r"Magnolie ($60^\circ$) $=20\ \mathrm{m}^2$, tedy celá plocha $\frac{360}{60}\cdot20=120\ \mathrm{m}^2$ (na $1^\circ$ připadá $\frac{1}{3}\ \mathrm{m}^2$).",
          r"11.1: jabloně $105^\circ=35\ \mathrm{m}^2$; $35-20=15$ — A.",
          r"11.2: hortenzie a součet levandule $+$ bazalka nejsou v poměru $1:1{,}5$ — N.",
          r"11.3: růže $90^\circ=30\ \mathrm{m}^2$, což není méně než $30$ — N."],
    ans=r"11.1: A; 11.2: N; 11.3: N",
    svg=fig(7, (75, 165, 480, 350)), fn=FN,
    alt="Kruhový diagram rozdělení plochy zahrady mezi 6 druhů rostlin (magnolie, jabloň, růže, hortenzie, levandule, bazalka) s vyznačenými úhly výsečí.",
    cap="",
    codes=["zs2", "r9", "procenta", "statistika", "porozumeni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží dva shodné rovnoramenné trojúhelníky a přímka $p$ rovnoběžná se základnou jednoho z nich. Druhý trojúhelník má právě jedno rameno rovnoběžné s ramenem prvního trojúhelníku (viz obrázek); je vyznačen úhel $40^\circ$.",
         r"Jaká je velikost úhlu $\alpha$? (Velikosti neměřte, ale vypočtěte.)"],
    opts=[r"A) $160^\circ$", r"B) $140^\circ$", r"C) $130^\circ$", r"D) $110^\circ$", r"E) jiná velikost"],
    solp=[r"Rovnoramenný trojúhelník s úhlem $40^\circ$ při vrcholu má úhly při základně $\frac{180^\circ-40^\circ}{2}=70^\circ$.",
          r"Z rovnoběžnosti přímky $p$ se základnou a rovnoběžnosti ramen vychází $\alpha=180^\circ-40^\circ=140^\circ$."],
    ans=r"B) $140^\circ$",
    svg=fig(8, (78, 66, 460, 175)), fn=FN,
    alt="Dva shodné rovnoramenné trojúhelníky a přímka p rovnoběžná se základnou jednoho z nich; vyznačený úhel 40° a hledaný úhel alfa.",
    cap="",
    codes=["zs2", "r9", "geometrie", "planimetrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Ze shodných bílých a šedých krychliček byla sestavena krychle $4\times4\times4$. Šedé krychličky byly umístěny vždy podél jedné ze dvou úhlopříček každé stěny krychle (viz obrázek). Všechny zbývající krychličky jsou bílé.",
         r"Jaký je počet všech bílých krychliček v krychli?"],
    opts=[r"A) méně než $36$", r"B) $36$", r"C) $48$", r"D) $54$", r"E) $72$"],
    solp=[r"Krychle má $4^3=64$ krychliček. Šedé leží na stěnových úhlopříčkách; po odečtení sdílených hranových a rohových krychliček je šedých $16$.",
          r"Bílých je $64-16=48$."],
    ans=r"C) $48$",
    svg=fig(8, (300, 272, 561, 420)), fn=FN,
    alt="Krychle 4×4×4 sestavená z bílých a šedých krychliček; šedé leží podél úhlopříček každé stěny.",
    cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "argumentace", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Na výrobu dortu byly použity dvě formy tvaru rotačního válce. Poloměr podstavy první formy je $8\ \mathrm{cm}$, druhé o čtvrtinu menší; výška obou je $5\ \mathrm{cm}$. Každý korpus má stejný objem jako forma, v níž byl upečen.",
         r"Jaký je celkový objem obou korpusů dvoupatrového dortu?"],
    opts=[r"A) $350\pi\ \mathrm{cm}^3$", r"B) $400\pi\ \mathrm{cm}^3$", r"C) $450\pi\ \mathrm{cm}^3$", r"D) $500\pi\ \mathrm{cm}^3$", r"E) $550\pi\ \mathrm{cm}^3$"],
    solp=[r"První forma: $V_1=\pi\cdot8^2\cdot5=320\pi\ \mathrm{cm}^3$.",
          r"Druhá forma: poloměr $6\ \mathrm{cm}$, $V_2=\pi\cdot6^2\cdot5=180\pi\ \mathrm{cm}^3$; celkem $500\pi\ \mathrm{cm}^3$."],
    ans=r"D) $500\pi\ \mathrm{cm}^3$",
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 15", pts=6, mins=6, diff="3",
    zad=[r"Na táboře bylo $80$ dětí, $5$ vedoucích a $4$ instruktoři.",
         r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Vedoucí si všechny děti rozdělili do stejně početných oddílů, každý vedoucí měl jeden oddíl. Kolik procent všech dětí měl na starost jeden vedoucí?",
         r"15.2 Mladších dětí bylo o jednu třetinu méně než starších. O kolik procent bylo starších dětí více než mladších?",
         r"15.3 Do lesa šla čtvrtina všech chlapců a polovina všech dívek, přičemž chlapců šlo o $4$ méně než dívek. Kolik procent všech dětí tvořily dívky?"],
    opts=[r"A) $20\ \%$", r"B) $25\ \%$", r"C) $33\ \%$", r"D) $40\ \%$", r"E) $45\ \%$", r"F) $50\ \%$"],
    solp=[r"15.1: $5$ oddílů po $16$ dětech; jeden vedoucí má $\frac{16}{80}=20\ \%$ — A.",
          r"15.2: mladší $=\frac{2}{3}$ starších; $\frac{S-\frac{2}{3}S}{\frac{2}{3}S}=\frac{1}{2}=50\ \%$ — F.",
          r"15.3: $\frac{1}{4}C=\frac{1}{2}D-4$ a $C+D=80$; odtud $D=32$, tj. $\frac{32}{80}=40\ \%$ — D."],
    ans=r"15.1: A ($20\ \%$); 15.2: F ($50\ \%$); 15.3: D ($40\ \%$)",
    codes=["zs2", "r9", "procenta", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2025 M9B · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Mirek postupně odříkával všechna přirozená čísla od $1$ do $1\,000$. Za každým druhým číslem udělal pauzu, během níž Zuzka řekla součet posledních dvou čísel vyslovených Mirkem. Začátek: $1, 2, \mathbf{3}, 3, 4, \mathbf{7}, 5, 6, \mathbf{11}, \dots$ (tučná čísla řekla Zuzka).",
         r"16.1 Určete číslo, které zaznělo mezi čísly $24$ a $25$.",
         r"16.2 Jako $90.$ v pořadí bylo vysloveno číslo $C$, které později zaznělo ještě jednou. Určete číslo vyslovené bezprostředně předtím, než podruhé zaznělo $C$.",
         r"16.3 Určete největší číslo, které mezi prvními $150$ vyslovenými čísly zaznělo dvakrát."],
    solp=[r"Mirek říká dvojice $(2n-1,2n)$, po každé Zuzka součet $4n-1$.",
          r"16.1: mezi $24$ a $25$ zazní Zuzčin součet $23+24=47$.",
          r"16.2: $90.$ číslo je $3\cdot30$, tedy Zuzčin součet $4\cdot30-1=119=C$; Mirek řekne $119$ v dvojici $(119,120)$, těsně předtím zazní Zuzčino $4\cdot59-1=235$.",
          r"16.3: mezi prvními $150$ čísly ($50$ dvojic) je největší dvakrát zaznělé číslo $99$ (Zuzčin součet $4\cdot25-1$ i Mirkovo $99$)."],
    ans=r"16.1: $47$; 16.2: $235$; 16.3: $99$",
    codes=["zs2", "r9", "posloupnosti", "aritmetika", "argumentace", "bez-kalkulacky", "bez-kontextu"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2025")
print("Úloh:", len(P))
for path, size, names in written:
    print("  %s : %d B, %d úloh" % (path, size, len(names)))
