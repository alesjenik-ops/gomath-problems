# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9D 2022 (druhý náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9D_2022_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2022, druhý náhradní termín (M9D)"
CCODE = "M9PDD22C0T04"
YR = 2022
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2022 M9D · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypište všechny dělitele čísla $95$, které jsou větší než $1$ a menší než $95$."],
    solp=[r"$95=5\cdot19$. Dělitelé čísla $95$ jsou $1$, $5$, $19$, $95$; v požadovaném rozmezí leží $5$ a $19$."],
    ans=r"$5$ a $19$",
    codes=["zs2", "r9", "aritmetika", "cisla", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"Vypočtěte:",
         r"2.1 \quad $(-3)^2-5^2-4\cdot(-4)=$",
         r"2.2 \quad $(0{,}08-1):0{,}2=$"],
    solp=[r"2.1: $9-25-(-16)=9-25+16=0$.",
          r"2.2: $(-0{,}92):0{,}2=-4{,}6$."],
    ans=r"2.1: $0$; 2.2: $-4{,}6$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\left(\dfrac{12}{5}\cdot\dfrac{3}{20}-\dfrac{3}{20}\right):\dfrac{7}{25}=$",
         r"3.2 \quad $\dfrac{12}{\,2+\frac{2}{3}\,}\cdot\dfrac{2\cdot\frac{2}{3}}{18}=$"],
    solp=[r"3.1: $\frac{12}{5}\cdot\frac{3}{20}=\frac{36}{100}=\frac{9}{25}$; $\frac{9}{25}-\frac{3}{20}=\frac{36-15}{100}=\frac{21}{100}$; $\frac{21}{100}:\frac{7}{25}=\frac{21}{100}\cdot\frac{25}{7}=\frac{3}{4}$.",
          r"3.2: jmenovatel $2+\frac{2}{3}=\frac{8}{3}$, tedy $\frac{12}{8/3}=\frac{12\cdot3}{8}=\frac{9}{2}$; dále $2\cdot\frac{2}{3}=\frac{4}{3}$, tedy $\frac{4/3}{18}=\frac{4}{54}=\frac{2}{27}$; $\frac{9}{2}\cdot\frac{2}{27}=\frac{18}{54}=\frac{1}{3}$."],
    ans=r"3.1: $\frac{3}{4}$; 3.2: $\frac{1}{3}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 Zjednodušte (výsledný výraz nesmí obsahovat závorky ani znak pro odmocninu): $(10x-8)-x\cdot\sqrt{100-64}=$",
         r"4.2 Do rámečků doplňte chybějící čísla $a$, $b$ tak, aby platila rovnost: $(y+a)^2=y^2+10y+b$",
         r"4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(6n+1)\cdot(1-2n-4n)+(1-2n)\cdot(-4n)=$"],
    solp=[r"4.1: $\sqrt{100-64}=\sqrt{36}=6$; $(10x-8)-6x=4x-8$.",
          r"4.2: $(y+5)^2=y^2+10y+25$, tedy $a=5$ a $b=25$.",
          r"4.3: $(6n+1)(1-6n)=1-36n^2$; $(1-2n)(-4n)=-4n+8n^2$; součet $-28n^2-4n+1$."],
    ans=r"4.1: $4x-8$; 4.2: $5$ a $25$; 4.3: $-28n^2-4n+1$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $x+0{,}2\cdot(5x+0{,}9)=x:5$",
         r"5.2 \quad $7\cdot\dfrac{y-3}{6}-\dfrac{6y+6}{9}=\dfrac{1}{3}$"],
    solp=[r"5.1: $x+x+0{,}18=0{,}2x\Rightarrow2x+0{,}18=0{,}2x\Rightarrow1{,}8x=-0{,}18\Rightarrow x=-0{,}1$.",
          r"5.2: vynásobíme $18$: $21(y-3)-2(6y+6)=6\Rightarrow21y-63-12y-12=6\Rightarrow9y=81\Rightarrow y=9$."],
    ans=r"5.1: $x=-0{,}1$; 5.2: $y=9$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 6", pts=3, mins=6, diff="3",
    zad=[r"Stejné činky jsou baleny po $6$ kusech do stejných krabic. V obchodě se sportovními potřebami mají čtyři krabice s činkami, dvě z těchto krabic jsou plné, dvě poloprázdné a vše dohromady váží $47\ \mathrm{kg}$. V každé poloprázdné krabici zůstaly jen $3$ činky. Obě poloprázdné krabice s činkami váží celkem $16\ \mathrm{kg}$.",
         r"Vypočtěte, kolik kilogramů váží",
         r"6.1 jedna plná krabice s činkami,",
         r"6.2 jedna činka,",
         r"6.3 jedna prázdná krabice."],
    solp=[r"Označme hmotnost prázdné krabice $b$ a jedné činky $c$. Plná krabice váží $b+6c$, poloprázdná $b+3c$.",
          r"Obě poloprázdné: $2(b+3c)=16\Rightarrow b+3c=8$. Vše dohromady: $2(b+6c)+2(b+3c)=47\Rightarrow4b+18c=47$.",
          r"Z $b=8-3c$: $4(8-3c)+18c=47\Rightarrow32+6c=47\Rightarrow c=2{,}5$; $b=8-7{,}5=0{,}5$. Plná: $b+6c=0{,}5+15=15{,}5$."],
    ans=r"6.1: $15{,}5\ \mathrm{kg}$; 6.2: $2{,}5\ \mathrm{kg}$; 6.3: $0{,}5\ \mathrm{kg}$",
    codes=["zs2", "r9", "rovnice", "slovni", "modelovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 7", pts=4, mins=7, diff="4",
    zad=[r"Z nádvoří se chodí nahoru na ochoz věže po $80$ stejných vyšších schodech, zatímco zpět na nádvoří se chodí dolů jiným schodištěm po $96$ stejných nižších schodech. Obě schodiště jsou ve dvou místech propojena odpočívadly (viz obrázek).",
         r"Václav šel z nádvoří nahoru a po $60$ schodech potkal na 2. odpočívadle Danu, která šla dolů. Když Dana sešla ještě o $30$ schodů níže, potkala na 1. odpočívadle Evu, která šla nahoru.",
         r"7.1 Vypočtěte, kolik schodů sešla Dana dolů z ochozu, než potkala Václava.",
         r"7.2 Vypočtěte, kolik schodů vyšla Eva nahoru z nádvoří, než potkala Danu."],
    solp=[r"Jeden schod nahoru překoná $\frac{1}{80}$ výšky věže, jeden schod dolů $\frac{1}{96}$ výšky.",
          r"7.1: Václav vyšel $60$ z $80$ schodů, 2. odpočívadlo je tedy ve výšce $\frac{60}{80}=\frac{3}{4}$ výšky. Z ochozu k němu klesneme o $\frac{1}{4}$ výšky, tj. $\frac{1}{4}\cdot96=24$ schodů dolů.",
          r"7.2: 1. odpočívadlo je o $30$ nižších schodů níže, tj. o $\frac{30}{96}=\frac{5}{16}$ výšky; je ve výšce $\frac{3}{4}-\frac{5}{16}=\frac{7}{16}$ výšky. Eva vyšla nahoru $\frac{7}{16}\cdot80=35$ schodů."],
    ans=r"7.1: $24$ schodů; 7.2: $35$ schodů",
    svg=fig(4, (66, 175, 530, 345)), fn=FN,
    alt="Schéma věže: schodiště nahoru na ochoz (80 vyšších schodů) a schodiště dolů na nádvoří (96 nižších schodů), obě propojena v úrovni 1. a 2. odpočívadla.", cap="",
    codes=["zs2", "r9", "slovni", "pomer", "uvazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 8", pts=3, mins=5, diff="3",
    zad=[r"Obrazec se skládá z tmavého čtverce, dvou shodných bílých rovnoramenných trojúhelníků a dvou shodných bílých lichoběžníků (viz obrázek). S každou stranou čtverce splývá základna jednoho bílého útvaru.",
         r"Tmavý čtverec má obsah $144\ \mathrm{cm}^2$, což je polovina obsahu celého obrazce. Jeden trojúhelník má obsah $30\ \mathrm{cm}^2$. Délka kratší základny lichoběžníku je $9\ \mathrm{cm}$.",
         r"8.1 Vypočtěte v cm výšku na základnu rovnoramenného trojúhelníku.",
         r"8.2 Vypočtěte v cm výšku lichoběžníku."],
    solp=[r"Strana čtverce $a=\sqrt{144}=12\ \mathrm{cm}$; to je delší základna trojúhelníku i lichoběžníku.",
          r"8.1: $\frac{1}{2}\cdot12\cdot v=30\Rightarrow 6v=30\Rightarrow v=5\ \mathrm{cm}$.",
          r"Celý obrazec má obsah $288\ \mathrm{cm}^2$, bílé útvary dohromady $144\ \mathrm{cm}^2$; dva trojúhelníky $60\ \mathrm{cm}^2$, tedy dva lichoběžníky $84\ \mathrm{cm}^2$, jeden $42\ \mathrm{cm}^2$.",
          r"8.2: $\frac{1}{2}(12+9)\cdot v=42\Rightarrow10{,}5\,v=42\Rightarrow v=4\ \mathrm{cm}$."],
    ans=r"8.1: $5\ \mathrm{cm}$; 8.2: $4\ \mathrm{cm}$",
    svg=fig(5, (405, 70, 522, 182)), fn=FN,
    alt="Obrazec: uprostřed tmavý čtverec, na jeho protějších stranách dva bílé rovnoramenné trojúhelníky (nahoře a dole) a dva bílé lichoběžníky (vlevo a vpravo).", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obsah", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 9", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).",
         r"Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je střed tohoto rovnoběžníku. Na přímce $p$ leží vrchol $B$ rovnoběžníku $ABCD$. Úhel $ASB$ má velikost $120^\circ$.",
         r"Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte."],
    solp=[r"U bodu $S$ sestrojíme od polopřímky $SA$ úhel $120^\circ$; jeho rameno protne přímku $p$ v bodě $B$ (vrchol $B$ leží na $p$ a zároveň splňuje $|\angle ASB|=120^\circ$).",
          r"Bod $S$ je střed rovnoběžníku, proto je středem úhlopříček $AC$ i $BD$: vrchol $C$ je obraz $A$ ve středové souměrnosti se středem $S$ a vrchol $D$ obraz $B$. Rovnoběžník $ABCD$ narýsujeme."],
    ans=r"Konstrukce rovnoběžníku $ABCD$ ($B$ na přímce $p$, $|\angle ASB|=120^\circ$, $S$ střed).",
    svg=fig(6, (66, 120, 530, 360)), fn=FN,
    alt="V rovině leží bod A na přímce p a bod S mimo přímku p.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body $C$, $Q$ a přímka $p$ (viz obrázek).",
         r"Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Ramena mají délku $5\ \mathrm{cm}$. Na přímce $p$ leží jeden vrchol trojúhelníku $ABC$. Bodem $Q$ prochází osa souměrnosti trojúhelníku $ABC$.",
         r"Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Osa souměrnosti rovnoramenného trojúhelníku se základnou $AB$ prochází vrcholem $C$ i středem $AB$; prochází body $C$ a $Q$, je to tedy přímka $CQ$.",
          r"Vrchol ležící na přímce $p$ (jeden z bodů $A$, $B$) najdeme jako průsečík přímky $p$ s kružnicí se středem $C$ a poloměrem $5\ \mathrm{cm}$; druhý základnový vrchol je jeho obrazem v osové souměrnosti podle přímky $CQ$. Podle počtu průsečíků může mít úloha více řešení."],
    ans=r"Konstrukce rovnoramenného trojúhelníku $ABC$ (osa $CQ$, ramena $5\ \mathrm{cm}$, jeden vrchol na $p$); nutno najít všechna řešení.",
    svg=fig(7, (80, 110, 525, 378)), fn=FN,
    alt="V rovině leží body C a Q a přímka p, která jimi neprochází.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$ (viz obrázek). Každý z nich má pouze jednu osu souměrnosti.",
         r"V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (sestrojených svisle, vodorovně nebo šikmo).",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 Správně upravený útvar $A$ má pouze $2$ osy souměrnosti.",
         r"11.2 Správně upravený útvar $B$ má pouze $2$ osy souměrnosti.",
         r"11.3 Správně upravený útvar $C$ má pouze $1$ osu souměrnosti."],
    solp=[r"V každém útvaru přemístíme právě jeden tmavý čtvereček tak, aby výsledný útvar měl co nejvíce os souměrnosti.",
          r"11.1: útvar $A$ lze upravit tak, že má právě $2$ osy souměrnosti — tvrzení je pravdivé (A).",
          r"11.2: nejlépe upravený útvar $B$ má jiný počet os než právě $2$ (lze dosáhnout více os souměrnosti) — tvrzení je nepravdivé (N).",
          r"11.3: nejlépe upravený útvar $C$ má více než $1$ osu souměrnosti — tvrzení je nepravdivé (N)."],
    ans=r"11.1: A; 11.2: N; 11.3: N",
    svg=fig(8, (70, 138, 528, 291)), fn=FN,
    alt="Tři útvary A, B, C složené z tmavých čtverečků ve čtvercové síti; každý má jednu osu souměrnosti.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "soumernost", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Čtyřúhelník je rozdělen na dva tmavé rovnostranné trojúhelníky, jeden bílý čtyřúhelník a jeden bílý trojúhelník (viz obrázek). Jsou vyznačeny úhly $41^\circ$, $36^\circ$ a hledaný úhel $\varphi$.",
         r"Jaká je velikost úhlu $\varphi$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Ve vrcholu na spodní přímce se stýkají tři úhly tvořící přímý úhel: úhel bílého trojúhelníku, vyznačený úhel $36^\circ$ a úhel rovnostranného trojúhelníku $60^\circ$. Úhel bílého trojúhelníku při tomto vrcholu je $180^\circ-36^\circ-60^\circ=84^\circ$.",
          r"V bílém trojúhelníku jsou úhly $41^\circ$, $84^\circ$ a třetí úhel $180^\circ-41^\circ-84^\circ=55^\circ$. Úhel $\varphi$ je vedlejší k tomuto úhlu (leží na přímém rameni), takže $\varphi=180^\circ-55^\circ=125^\circ$.",
          r"$125^\circ>120^\circ$, správná odpověď je E."],
    ans=r"E) větší než $120^\circ$",
    opts=[r"A) $105^\circ$", r"B) $110^\circ$", r"C) $115^\circ$", r"D) $120^\circ$", r"E) větší než $120^\circ$"],
    svg=fig(8, (295, 518, 522, 616)), fn=FN,
    alt="Čtyřúhelník rozdělený na dva tmavé rovnostranné trojúhelníky, bílý čtyřúhelník a bílý trojúhelník; vyznačené úhly 41°, 36° a hledaný úhel φ.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník, jehož dvě delší strany měří $17\ \mathrm{cm}$ a $15\ \mathrm{cm}$. Výška hranolu je $5\ \mathrm{cm}$. Obě podstavy hranolu jsou tmavé, ostatní stěny jsou bílé.",
         r"Ze čtyř těchto trojbokých hranolů je slepeno těleso, které má dvě shodné stěny tmavé a zbývající čtyři stěny bílé.",
         r"Jaký obsah mají dohromady všechny bílé stěny slepeného tělesa?"],
    solp=[r"Přepona pravoúhlého trojúhelníku je $17\ \mathrm{cm}$, jedna odvěsna $15\ \mathrm{cm}$, druhá $\sqrt{17^2-15^2}=\sqrt{64}=8\ \mathrm{cm}$.",
          r"Bílé (obdélníkové) stěny jednoho hranolu mají obsahy $8\cdot5=40$, $15\cdot5=75$ a $17\cdot5=85\ \mathrm{cm}^2$, dohromady $200\ \mathrm{cm}^2$; u čtyř hranolů $800\ \mathrm{cm}^2$.",
          r"Slepené těleso má vně jen $4$ bílé stěny; slepené (vnitřní) obdélníkové stěny mají obsah $330\ \mathrm{cm}^2$, takže vnější bílé stěny mají obsah $800-330=470\ \mathrm{cm}^2$."],
    ans=r"D) $470\ \mathrm{cm}^2$",
    opts=[r"A) menší než $300\ \mathrm{cm}^2$", r"B) $300\ \mathrm{cm}^2$", r"C) $330\ \mathrm{cm}^2$", r"D) $470\ \mathrm{cm}^2$", r"E) větší než $470\ \mathrm{cm}^2$"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Těleso je slepeno ze čtyř shodných trojbokých kolmých hranolů z úlohy 13 (podstava je pravoúhlý trojúhelník s odvěsnami $8\ \mathrm{cm}$ a $15\ \mathrm{cm}$, výška hranolu je $5\ \mathrm{cm}$).",
         r"Jaký je objem slepeného tělesa?"],
    solp=[r"Obsah podstavy jednoho hranolu je $\frac{1}{2}\cdot8\cdot15=60\ \mathrm{cm}^2$, objem $60\cdot5=300\ \mathrm{cm}^3$.",
          r"Slepením se objem nemění, celkem $4\cdot300=1\,200\ \mathrm{cm}^3$."],
    ans=r"B) $1\,200\ \mathrm{cm}^3$",
    opts=[r"A) $960\ \mathrm{cm}^3$", r"B) $1\,200\ \mathrm{cm}^3$", r"C) $1\,280\ \mathrm{cm}^3$", r"D) $1\,360\ \mathrm{cm}^3$", r"E) jiný objem"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Do prosince roku $2020$ prodělal covid-19 každý dvacátý Čech. Kolik procent Čechů prodělalo covid-19 do prosince roku $2020$?",
         r"15.2 Počet novorozenců tvořil v dubnu $\frac{26}{25}$ počtu novorozenců v březnu. O kolik procent byl počet novorozenců v dubnu vyšší než v březnu?",
         r"15.3 Teplá kapalina v nádobě po vychladnutí zmenšila svůj objem o $\frac{2}{27}$. O kolik procent byl objem teplé kapaliny větší než objem vychladlé kapaliny?",
         r"Nabídka: A) $4\ \%$; B) $5\ \%$; C) $6\ \%$; D) $7\ \%$; E) $8\ \%$; F) jiný počet procent."],
    solp=[r"15.1: každý dvacátý $=\frac{1}{20}=5\ \%$ — B.",
          r"15.2: $\frac{26}{25}=1{,}04$, tedy o $4\ \%$ více — A.",
          r"15.3: vychladlá kapalina má objem $\frac{25}{27}$ teplé; teplá je o $\frac{2/27}{25/27}=\frac{2}{25}=8\ \%$ větší — E."],
    ans=r"15.1: B; 15.2: A; 15.3: E",
    codes=["zs2", "r9", "procenta", "zlomky", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2022 M9D · úloha 16", pts=4, mins=6, diff="4",
    zad=[r"Řada je vytvořena z celých čísel. První trojice čísel je $0$, $1$, $2$. Každou další trojici vytvoříme tak, že jednotlivá čísla z předchozí trojice zvětšíme o $1$. Na 1. až 18. místě řady je následujících 18 čísel:",
         r"$0,\ 1,\ 2,\quad 1,\ 2,\ 3,\quad 2,\ 3,\ 4,\quad 3,\ 4,\ 5,\quad 4,\ 5,\ 6,\quad 5,\ 6,\ 7,\quad \ldots$",
         r"16.1 Určete, na kolikátém místě řady je poprvé číslo $12$.",
         r"16.2 Určete, na kolika místech řady je mezi prvními $125$ čísly uvedeno liché číslo.",
         r"16.3 Určete, které číslo je na 152. místě řady."],
    solp=[r"$k$-tá trojice je $(k-1,\ k,\ k+1)$ a zabírá místa $3k-2$, $3k-1$, $3k$.",
          r"16.1: číslo $12$ se poprvé objeví jako největší člen trojice $k=11$ (trojice $10,11,12$), tedy na místě $3\cdot11=33$.",
          r"16.2: $125=3\cdot41+2$. Pro liché $k$ je v trojici jedno liché číslo, pro sudé $k$ dvě lichá. Mezi trojicemi $1$ až $41$ je $21$ lichých a $20$ sudých $k$: $21\cdot1+20\cdot2=61$. Místa $124$ a $125$ jsou čísla $41$ (liché) a $42$ (sudé), přidají $1$ — celkem $62$.",
          r"16.3: $152=3\cdot50+2$, jde o 2. člen trojice $k=51$ $(50,51,52)$, tedy číslo $51$."],
    ans=r"16.1: na 33. místě; 16.2: na 62 místech; 16.3: $51$",
    codes=["zs2", "r9", "posloupnosti", "aritmetika", "uvazovani", "vypocet", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9D-2022")
for path, size, names in written:
    print("%s  (%d bytes, %d úloh)" % (path, size, len(names)))
