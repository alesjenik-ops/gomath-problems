# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9A 2021 (1. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2021_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2021, 1. řádný termín (M9A)"
CCODE = "M9PAD21C0T01"
YR = 2021
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2021 M9A · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Určete, na kolik $16$minutových intervalů lze rozdělit $1{,}6$ hodiny."],
    solp=[r"$1{,}6$ hodiny $=1{,}6\cdot60=96$ minut; $96:16=6$."],
    ans=r"na $6$ intervalů",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 2", pts=2, mins=3, diff="3",
    zad=[r"Doplňte do rámečku takové číslo, aby platila rovnost.",
         r"2.1 \quad $0{,}3\ \mathrm{m}^2-52\ \mathrm{cm}^2=\square\ \mathrm{cm}^2$",
         r"2.2 \quad $\square\ \mathrm{dm}^3-0{,}04\ \mathrm{m}^3=250\ \mathrm{cm}^3$"],
    solp=[r"2.1: $0{,}3\ \mathrm{m}^2=3000\ \mathrm{cm}^2$; $3000-52=2948\ \mathrm{cm}^2$.",
          r"2.2: $0{,}04\ \mathrm{m}^3=40\ \mathrm{dm}^3$ a $250\ \mathrm{cm}^3=0{,}25\ \mathrm{dm}^3$; hledané číslo $=40+0{,}25=40{,}25$."],
    ans=r"2.1: $2948$; 2.2: $40{,}25$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{5}{8}\cdot\dfrac{10}{9}-\dfrac{4}{9}\right):\left(8\cdot\dfrac{1}{6}\right)=$",
         r"3.2 \quad $\dfrac{2-\frac{13}{10}}{\frac{5}{3}-\frac{1}{2}}=$"],
    solp=[r"3.1: $\frac{5}{8}\cdot\frac{10}{9}=\frac{50}{72}=\frac{25}{36}$; $\frac{25}{36}-\frac{4}{9}=\frac{25}{36}-\frac{16}{36}=\frac{9}{36}=\frac{1}{4}$; $8\cdot\frac{1}{6}=\frac{4}{3}$; $\frac{1}{4}:\frac{4}{3}=\frac{1}{4}\cdot\frac{3}{4}=\frac{3}{16}$.",
          r"3.2: čitatel $2-\frac{13}{10}=\frac{20-13}{10}=\frac{7}{10}$; jmenovatel $\frac{5}{3}-\frac{1}{2}=\frac{10-3}{6}=\frac{7}{6}$; $\frac{7}{10}:\frac{7}{6}=\frac{7}{10}\cdot\frac{6}{7}=\frac{6}{10}=\frac{3}{5}$."],
    ans=r"3.1: $\frac{3}{16}$; 3.2: $\frac{3}{5}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 Rozložte na součin podle vzorce: $9a^2-30a+25=$",
         r"4.2 Vynásobte (výsledný výraz nesmí obsahovat závorky): $(3x+y)\cdot(3x-2)=$",
         r"4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(4n-1)\cdot(4n+1)-8n\cdot(n-1)=$"],
    solp=[r"4.1: $9a^2-30a+25=(3a)^2-2\cdot3a\cdot5+5^2=(3a-5)^2$.",
          r"4.2: $(3x+y)(3x-2)=9x^2-6x+3xy-2y=9x^2+3xy-6x-2y$.",
          r"4.3: $(4n-1)(4n+1)=16n^2-1$; $8n(n-1)=8n^2-8n$; $16n^2-1-(8n^2-8n)=8n^2+8n-1$."],
    ans=r"4.1: $(3a-5)^2$; 4.2: $9x^2+3xy-6x-2y$; 4.3: $8n^2+8n-1$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $0{,}3\cdot2-0{,}5x\cdot2+0{,}4x=x+3{,}8$",
         r"5.2 \quad $\dfrac{3}{4}\cdot(4-y)+\dfrac{3}{2}\cdot(y+2)=6+\dfrac{3y}{2}$"],
    solp=[r"5.1: $0{,}6-x+0{,}4x=x+3{,}8\Rightarrow0{,}6-0{,}6x=x+3{,}8\Rightarrow-3{,}2=1{,}6x\Rightarrow x=-2$.",
          r"5.2: levá strana $3-\frac{3y}{4}+\frac{3y}{2}+3=6+\frac{3y}{4}$; rovnice $6+\frac{3y}{4}=6+\frac{3y}{2}\Rightarrow\frac{3y}{4}=\frac{3y}{2}\Rightarrow3y=6y\Rightarrow y=0$."],
    ans=r"5.1: $x=-2$; 5.2: $y=0$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 6", pts=3, mins=5, diff="3",
    zad=[r"Firma zaměstnává $200$ osob. Během epidemie museli někteří pracovat z domova. Včera byla na pracovišti jedna třetina žen zaměstnaných ve firmě a dvě pětiny mužů zaměstnaných ve firmě, všichni ostatní pracovali z domova. Počet všech žen zaměstnaných ve firmě označte $x$.",
         r"6.1 V závislosti na veličině $x$ vyjádřete počet žen, které byly včera na pracovišti.",
         r"6.2 V závislosti na veličině $x$ vyjádřete počet mužů, kteří byli včera na pracovišti.",
         r"6.3 Včera bylo na pracovišti celkem $70$ osob zaměstnaných ve firmě. Vypočtěte, kolik žen firma zaměstnává."],
    solp=[r"6.1: počet žen na pracovišti $=\frac{x}{3}$.",
          r"6.2: mužů je ve firmě $200-x$, na pracovišti byly dvě pětiny, tedy $\frac{2}{5}\cdot(200-x)$.",
          r"6.3: $\frac{x}{3}+\frac{2}{5}\cdot(200-x)=70$; vynásobením $15$: $5x+6(200-x)=1050\Rightarrow5x+1200-6x=1050\Rightarrow-x=-150\Rightarrow x=150$."],
    ans=r"6.1: $\frac{x}{3}$; 6.2: $\frac{2}{5}\cdot(200-x)$; 6.3: $150$ žen",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 7", pts=4, mins=6, diff="4",
    zad=[r"Farmářka chová $3$ koně, ale nemá již pro ně žádné krmivo. Chovatel, který má pro svých $5$ koní krmivo na $120$ dní, farmářce dvě pětiny tohoto krmiva prodá. (Každý kůň spotřebuje za den stejné množství krmiva.)",
         r"Vypočtěte, za kolik dní",
         r"7.1 by veškeré chovatelovo krmivo spotřebovalo všech $8$ koní společně,",
         r"7.2 spotřebují chovatelovi koně krmivo, které chovatel neprodá,",
         r"7.3 spotřebují farmářčini koně krmivo, které farmářka zakoupí od chovatele."],
    solp=[r"Celkové množství krmiva $=5\ \text{koní}\cdot120\ \text{dní}=600$ koně-dní.",
          r"7.1: $600:8=75$ dní.",
          r"7.2: chovatel neprodá $\frac{3}{5}$ krmiva, tj. $\frac{3}{5}\cdot600=360$ koně-dní; jeho $5$ koní je spotřebuje za $360:5=72$ dní.",
          r"7.3: farmářka koupí $\frac{2}{5}\cdot600=240$ koně-dní; její $3$ koně je spotřebují za $240:3=80$ dní."],
    ans=r"7.1: $75$ dní; 7.2: $72$ dní; 7.3: $80$ dní",
    codes=["zs2", "r9", "aritmetika", "pomer", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"Síť kolmého čtyřbokého hranolu se skládá ze dvou shodných čtverců a obdélníku s rozměry $40\ \mathrm{cm}$ a $8\ \mathrm{cm}$ (viz náčrt obrysu sítě). Obdélník tvoří plášť hranolu, jeho delší strana $40\ \mathrm{cm}$ odpovídá obvodu čtvercové podstavy a kratší strana $8\ \mathrm{cm}$ výšce hranolu.",
         r"Vypočtěte",
         r"8.1 v cm$^2$ povrch hranolu,",
         r"8.2 v cm$^3$ objem hranolu."],
    solp=[r"Obvod čtvercové podstavy je $40\ \mathrm{cm}$, tedy strana $a=40:4=10\ \mathrm{cm}$; výška $h=8\ \mathrm{cm}$.",
          r"8.1: povrch $S=2a^2+40\cdot8=2\cdot100+320=200+320=520\ \mathrm{cm}^2$.",
          r"8.2: objem $V=a^2\cdot h=100\cdot8=800\ \mathrm{cm}^3$."],
    ans=r"8.1: $520\ \mathrm{cm}^2$; 8.2: $800\ \mathrm{cm}^3$",
    svg=fig(4, (210, 100, 505, 200)), fn=FN,
    alt="Náčrt obrysu sítě kolmého čtyřbokého hranolu: dva shodné čtverce (podstavy) a obdélník s rozměry 40 cm a 8 cm (plášť).", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 9", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží polopřímka BX a přímka $o$ (viz obrázek).",
         r"Bod B je vrchol trojúhelníku ABC. Přímka $o$ je osou strany AB. Velikost vnitřního úhlu BAC je $60^\circ$ a vrchol C leží na polopřímce BX.",
         r"Sestrojte vrcholy A, C trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte."],
    solp=[r"Přímka $o$ je osou úsečky AB, takže vrchol A je obrazem bodu B v osové souměrnosti podle $o$ (A leží na kolmici k $o$ vedené bodem B, ve stejné vzdálenosti od $o$ jako B).",
          r"Vrchol C leží na polopřímce BX a zároveň na rameni úhlu o velikosti $60^\circ$ sestrojeného při vrcholu A k úsečce AB; jejich průsečíkem je bod C.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce trojúhelníku ABC: A je souměrný s B podle osy $o$, C je průsečík polopřímky BX s ramenem úhlu $60^\circ$ při vrcholu A.",
    svg=fig(4, (80, 450, 510, 690)), fn=FN,
    alt="V rovině leží polopřímka BX (s vyznačeným bodem X) a přímka o.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body B, P a přímka $q$ procházející bodem B (viz obrázek).",
         r"Bod B je vrchol rovnoramenného lichoběžníku ABCD se základnou AB, rameno BC leží na přímce $q$. Úhlopříčky AC a BD se protínají v bodě P a jsou na sebe kolmé.",
         r"Sestrojte vrcholy A, C, D lichoběžníku ABCD, označte je písmeny a lichoběžník narýsujte."],
    solp=[r"Vrchol C leží na přímce $q$ a zároveň na přímce vedené bodem P kolmo k BP (protože úhlopříčky AC a BD jsou na sebe kolmé a P je jejich průsečík) — tím je C určen.",
          r"Bod A leží na přímce BP (na úhlopříčce BD prodloužené za P je vrchol D; A je na úhlopříčce AC, tj. na přímce PC) tak, aby AB byla základna a lichoběžník byl rovnoramenný; rovnoramenný lichoběžník je souměrný podle osy základny AB, čehož využijeme k dokončení konstrukce vrcholů A a D.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce rovnoramenného lichoběžníku ABCD (rameno BC na přímce $q$, kolmé úhlopříčky AC $\perp$ BD protínající se v bodě P).",
    svg=fig(5, (290, 95, 470, 430)), fn=FN,
    alt="V rovině leží bod B na přímce q, bod P mimo přímku q; přímka q prochází bodem B.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 11", pts=4, mins=6, diff="3",
    zad=[r"Děti mají mapu s měřítkem $1:50\,000$.",
         r"Alena ujela na koloběžce trasu délky $10\ \mathrm{km}$ a vypočetla, že na mapě je to $5\ \mathrm{cm}$. Beáta ušla trasu, která je na mapě zobrazena čarou délky $15\ \mathrm{cm}$. Čestmír ušel dvakrát delší trasu než Beáta.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 Alenin výpočet je správný.",
         r"11.2 Beáta ušla trasu délky $7{,}5\ \mathrm{km}$.",
         r"11.3 Na mapě je Beátina trasa o polovinu kratší než Čestmírova trasa."],
    solp=[r"11.1: $10\ \mathrm{km}=1\,000\,000\ \mathrm{cm}$; na mapě $1\,000\,000:50\,000=20\ \mathrm{cm}$, nikoli $5\ \mathrm{cm}$ — výpočet je chybný, tedy \textbf{N}.",
          r"11.2: $15\ \mathrm{cm}\cdot50\,000=750\,000\ \mathrm{cm}=7{,}5\ \mathrm{km}$ — \textbf{A}.",
          r"11.3: Čestmír ušel dvakrát delší trasu, na mapě je jeho trasa $30\ \mathrm{cm}$; Beátiných $15\ \mathrm{cm}$ je polovina, tedy o polovinu kratší — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "pomer", "procenta", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 12", pts=2, mins=3, diff="4",
    zad=[r"V rovině leží přímka AB a rovnoběžník ABCD. Rovnoběžník má vnitřní úhly o velikostech $\alpha$, $\delta$ (viz obrázek). Při vrcholu A svírá strana AD s přímkou AB na jedné straně úhel $\alpha$ (vnitřní úhel rovnoběžníku) a na druhé straně úhel $4\alpha$.",
         r"Jaká je velikost úhlu $\delta$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Úhly $4\alpha$ a $\alpha$ leží u vrcholu A na přímce AB, dohromady tvoří přímý úhel: $4\alpha+\alpha=180^\circ\Rightarrow5\alpha=180^\circ\Rightarrow\alpha=36^\circ$.",
          r"V rovnoběžníku jsou sousední úhly doplňkové: $\delta=180^\circ-\alpha=180^\circ-36^\circ=144^\circ$."],
    ans=r"D) $144^\circ$",
    opts=[r"A) menší než $108^\circ$", r"B) $108^\circ$", r"C) $135^\circ$", r"D) $144^\circ$", r"E) větší než $144^\circ$"],
    svg=fig(6, (338, 505, 540, 615)), fn=FN,
    alt="Přímka AB a rovnoběžník ABCD; při vrcholu A jsou vyznačeny úhly 4α a α, při vrcholu D úhel δ.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Pravoúhlý lichoběžník ABCD je úsečkou DP délky $12\ \mathrm{cm}$ rozdělen na čtverec PBCD a trojúhelník APD (viz obrázek). Obsah trojúhelníku APD je $6$krát menší než obsah čtverce PBCD. Z lichoběžníku ABCD oddělíme šedý trojúhelník ABC.",
         r"Jaký je obvod šedého trojúhelníku ABC?"],
    solp=[r"Strana čtverce PBCD je $DP=12\ \mathrm{cm}$, jeho obsah $=12^2=144\ \mathrm{cm}^2$; obsah trojúhelníku APD $=144:6=24\ \mathrm{cm}^2$.",
          r"Trojúhelník APD je pravoúhlý s odvěsnami AP a $PD=12$: $\frac{1}{2}\cdot AP\cdot12=24\Rightarrow AP=4\ \mathrm{cm}$.",
          r"V trojúhelníku ABC je $AB=AP+PB=4+12=16\ \mathrm{cm}$, $BC=12\ \mathrm{cm}$ a přepona $AC=\sqrt{16^2+12^2}=\sqrt{400}=20\ \mathrm{cm}$.",
          r"Obvod $=16+12+20=48\ \mathrm{cm}$."],
    ans=r"B) $48\ \mathrm{cm}$",
    opts=[r"A) menší než $48\ \mathrm{cm}$", r"B) $48\ \mathrm{cm}$", r"C) $50\ \mathrm{cm}$", r"D) $52\ \mathrm{cm}$", r"E) větší než $52\ \mathrm{cm}$"],
    svg=fig(7, (75, 95, 500, 245)), fn=FN,
    alt="Pravoúhlý lichoběžník ABCD rozdělený úsečkou DP na čtverec PBCD a trojúhelník APD; vpravo tentýž lichoběžník se šedě vyznačeným trojúhelníkem ABC.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"Všechny rodiny z Jižní a Severní ulice uvedly, kolik chovají psů. Výsledky jsou v tabulce (některá pole nejsou vyplněna).",
         r"Jižní ulice: počet všech rodin $48$; rodin s $0$ psy $33$; s $1$ psem (chybí); se $2$ psy $5$; se $3$ psy (chybí); aritmetický průměr počtu chovaných psů $0{,}5$.",
         r"Severní ulice: počet všech rodin (chybí); rodin s $0$ psy $23$; s $1$ psem $12$; se $2$ psy $1$; se $3$ psy (chybí).",
         r"Právě $3$ psy chová v Severní ulici dvakrát více rodin než v Jižní ulici. Kolik rodin bydlí v Severní ulici?"],
    solp=[r"Jižní ulice: celkový počet psů $=0{,}5\cdot48=24$. Označme počet rodin s $1$ psem $a$ a se $3$ psy $b$: $33+a+5+b=48\Rightarrow a+b=10$ a $a+2\cdot5+3b=24\Rightarrow a+3b=14$.",
          r"Odečtením: $2b=4\Rightarrow b=2$, tedy v Jižní ulici chovají $3$ psy $2$ rodiny.",
          r"V Severní ulici chovají $3$ psy $2\cdot2=4$ rodiny. Počet rodin v Severní ulici $=23+12+1+4=40$."],
    ans=r"A) $40$",
    opts=[r"A) $40$", r"B) $42$", r"C) $44$", r"D) $46$", r"E) jiný počet"],
    codes=["zs2", "r9", "aritmetika", "prumer", "uvazovani", "slovni", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Při úklidové akci „Čisté břehy“ měl každý dobrovolník naplnit jeden odpadkový pytel, ale $20\ \%$ dobrovolníků naplnilo ještě druhý pytel. Dobrovolníci tak naplnili o $130$ pytlů více, než se předpokládalo. Kolik pytlů celkem dobrovolníci naplnili?",
         r"15.2 Učitel matematiky obdržel peněžitý dar na nákup učebních pomůcek. Za $24\ \%$ daru zakoupil $3$ stejná kružítka na tabuli. Model tělesa stál $180$ korun, což představuje $2\ \%$ daru. Kolik korun stálo jedno kružítko?",
         r"15.3 Na $25\ \%$ rozlohy zemědělské půdy Jablonecka jsou pole, zbytek tvoří louky. Pastviny pro dobytek zabírají $20\ \%$ rozlohy luk, zbývajících $1\,800$ hektarů luk se využívá pro pěstování trávy na seno. Kolik hektarů zabírají pole na Jablonecku?",
         r"Nabídka: A) $650$; B) $675$; C) $720$; D) $750$; E) $780$; F) jiný počet."],
    solp=[r"15.1: $20\ \%$ dobrovolníků naplnilo druhý pytel, tj. $0{,}2\cdot N=130\Rightarrow N=650$ dobrovolníků; celkem naplnili $650+130=780$ pytlů — \textbf{E}.",
          r"15.2: $2\ \%$ daru $=180$ korun $\Rightarrow$ dar $=9000$ korun; $24\ \%$ daru $=0{,}24\cdot9000=2160$ korun za $3$ kružítka, jedno stojí $2160:3=720$ korun — \textbf{C}.",
          r"15.3: louky tvoří $75\ \%$; seno je $80\ \%$ luk $=1\,800\ \mathrm{ha}\Rightarrow$ louky $=1\,800:0{,}8=2\,250\ \mathrm{ha}$; to je $75\ \%$ celku $\Rightarrow$ celkem $2\,250:0{,}75=3\,000\ \mathrm{ha}$; pole $=25\ \%=750\ \mathrm{ha}$ — \textbf{D}."],
    ans=r"15.1: E; 15.2: C; 15.3: D",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2021 M9A · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Každý díl stavebnice se skládá ze tří stejných krychliček; všechny díly jsou stejné. Z dílů stavíme stále větší pyramidy (viz obrázek). Nejmenší pyramidu tvoří jediný díl. Druhá pyramida sestavená ze $3$ dílů má $1$ otvor, $4$ řady a ve spodní řadě $4$ krychličky. Každá další pyramida bude o dvě řady vyšší než předchozí.",
         r"16.1 Pyramida má ve spodní řadě $50$ krychliček. Určete počet otvorů ve druhé řadě zdola.",
         r"16.2 Pyramida má celkem $10$ otvorů. Určete počet krychliček v celé pyramidě.",
         r"16.3 Pyramida je sestavena z $21$ dílů. Určete počet krychliček ve spodní řadě."],
    solp=[r"$k$-tá pyramida má $2k$ řad, ve spodní řadě $2k$ krychliček, $\frac{k(k+1)}{2}$ dílů (tj. $\frac{3k(k+1)}{2}$ krychliček) a $\frac{k(k-1)}{2}$ otvorů; ve druhé řadě zdola je $k-1$ otvorů.",
          r"16.1: $2k=50\Rightarrow k=25$; otvorů $=k-1=24$.",
          r"16.2: $\frac{k(k-1)}{2}=10\Rightarrow k=5$; krychliček $=\frac{3\cdot5\cdot6}{2}=45$.",
          r"16.3: $\frac{k(k+1)}{2}=21\Rightarrow k=6$; ve spodní řadě $2k=12$."],
    ans=r"16.1: $24$ otvorů; 16.2: $45$ krychliček; 16.3: $12$ krychliček",
    svg=fig(9, (66, 150, 470, 310)), fn=FN,
    alt="Posloupnost pyramid z krychliček: 1., 2. a 3. pyramida a tři tečky; ve větších pyramidách jsou otvory.", cap="",
    codes=["zs2", "r9", "posloupnosti", "algebra", "vypocet", "uvazovani", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2021")
for path, size, names in written:
    print(path, size, "bytes,", len(names), "úloh")
