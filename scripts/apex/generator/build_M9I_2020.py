# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9I 2020 (ilustrační test, čtyřleté obory)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9I_2020_TS.pdf"
SRC = "CERMAT – Ilustrační test 2020, matematika 9 (čtyřleté obory)"
CCODE = "M9PID20C0T01"
YR = 2020
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2020 M9I · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte, kolikrát je úhel o velikosti $10^\circ$ větší než úhel o velikosti $0^\circ\,20'$."],
    solp=[r"$10^\circ=600'$ a $0^\circ\,20'=20'$; $\frac{600'}{20'}=30$."],
    ans=r"$30$krát",
    codes=["zs2", "r9", "uhly", "geometrie", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"Vypočtěte:",
         r"2.1 \quad $\sqrt{14{,}4:0{,}001}=$",
         r"2.2 \quad $0{,}5-(-0{,}3+0{,}5)\cdot2{,}1=$"],
    solp=[r"2.1: $\sqrt{14{,}4:0{,}001}=\sqrt{14\,400}=120$.",
          r"2.2: $0{,}5-(0{,}2)\cdot2{,}1=0{,}5-0{,}42=0{,}08$."],
    ans=r"2.1: $120$; 2.2: $0{,}08$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{\frac{5}{2}-\frac{2}{5}}{(-7)^2}=$",
         r"3.2 \quad $\dfrac{5}{3}\cdot\dfrac{9}{50}\cdot\left(1-\dfrac{4}{9}\right)-\dfrac{2}{3}=$"],
    solp=[r"3.1: čitatel $\frac{5}{2}-\frac{2}{5}=\frac{25-4}{10}=\frac{21}{10}$; jmenovatel $(-7)^2=49$; $\frac{21}{10}:49=\frac{21}{490}=\frac{3}{70}$.",
          r"3.2: $\frac{5}{3}\cdot\frac{9}{50}=\frac{3}{10}$; $1-\frac{4}{9}=\frac{5}{9}$; $\frac{3}{10}\cdot\frac{5}{9}=\frac{1}{6}$; $\frac{1}{6}-\frac{2}{3}=\frac{1-4}{6}=-\frac{1}{2}$."],
    ans=r"3.1: $\frac{3}{70}$; 3.2: $-\frac{1}{2}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"Zjednodušte (výsledný výraz nesmí obsahovat závorky):",
         r"4.1 \quad $\left(\dfrac{x}{3}+\dfrac{3}{2}\right)^2=$",
         r"4.2 \quad $5a\cdot(0{,}4b-2a+3)=$",
         r"4.3 \quad $(4+n)\cdot(4-n)+(3n-2)\cdot(-3)=$"],
    solp=[r"4.1: $\left(\frac{x}{3}\right)^2+2\cdot\frac{x}{3}\cdot\frac{3}{2}+\left(\frac{3}{2}\right)^2=\frac{1}{9}x^2+x+\frac{9}{4}$.",
          r"4.2: $5a\cdot0{,}4b-5a\cdot2a+5a\cdot3=2ab-10a^2+15a$.",
          r"4.3: $(16-n^2)+(-9n+6)=-n^2-9n+22$."],
    ans=r"4.1: $\frac{1}{9}x^2+x+\frac{9}{4}$; 4.2: $2ab-10a^2+15a$; 4.3: $-n^2-9n+22$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $6x-2=4\cdot\left(x-\dfrac{1}{2}\right)+2x$",
         r"5.2 \quad $3-y=\dfrac{3}{4}\cdot(2y-1)-2$"],
    solp=[r"5.1: pravá strana $4x-2+2x=6x-2$, tedy $6x-2=6x-2$ — rovnice platí pro každé $x$, má nekonečně mnoho řešení.",
          r"5.2: $3-y=\frac{3}{2}y-\frac{3}{4}-2=\frac{3}{2}y-\frac{11}{4}$; $3+\frac{11}{4}=\frac{3}{2}y+y$; $\frac{23}{4}=\frac{5}{2}y$; $y=\frac{23}{4}\cdot\frac{2}{5}=\frac{23}{10}=2{,}3$."],
    ans=r"5.1: nekonečně mnoho řešení; 5.2: $y=2{,}3$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 6", pts=4, mins=7, diff="3",
    zad=[r"Soutěže se zúčastnily tři týmy. Jejich výkony hodnotilo $10$ rozhodčích. Každý rozhodčí přidělil každému týmu jedno ze tří možných míst (každému týmu jiné). Tým získal za každé 1. místo $4$ body, za každé 2. místo $2$ body a za každé 3. místo $1$ bod. Zvítězil tým s nejvyšším počtem získaných bodů.",
         r"Do tabulky se zapisují počty přidělených míst a celkové počty bodů. Tým A získal v soutěži jen o $3$ body méně než vítězný tým.",
         r"Tabulka (počet 1. míst / počet 2. míst / počet 3. míst): Tým A: $3$ / $4$ / $3$; Tým B: — / — / —; Tým C: — / — / $3$.",
         r"6.1 Vypočtěte, kolik bodů získal tým A.",
         r"6.2 Vypočtěte, kolik bodů získaly dohromady týmy B a C.",
         r"6.3 Vypočtěte, kolik druhých míst získal tým B."],
    solp=[r"6.1: tým A $=3\cdot4+4\cdot2+3\cdot1=12+8+3=23$ bodů.",
          r"Každý z $10$ rozhodčích rozdělí $4+2+1=7$ bodů, celkem tedy $70$ bodů.",
          r"6.2: týmy B a C dohromady $70-23=47$ bodů.",
          r"6.3: v každém sloupci tabulky je součet míst $10$, proto tým B má 3. míst $10-3-3=4$. Vítěz má $23+3=26$ bodů. Označíme počet 1. míst týmu B jako $b$; pak 2. míst má $6-b$ a jeho body jsou $4b+2(6-b)+4=2b+16$. Z $2b+16=26$ plyne $b=5$, takže 2. míst má tým B $6-5=1$."],
    ans=r"6.1: $23$ bodů; 6.2: $47$ bodů; 6.3: $1$ druhé místo",
    codes=["zs2", "r9", "aritmetika", "slovni", "uvazovani", "grafy", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 7", pts=3, mins=5, diff="3",
    zad=[r"Při 1. vyučovací hodině bylo v aule čtyřikrát více chlapců než dívek. O přestávce před 2. vyučovací hodinou z auly odešlo $10$ dívek a $20$ chlapců.",
         r"Počet dívek, které byly v aule při 1. vyučovací hodině, označte $d$.",
         r"7.1 V závislosti na veličině $d$ vyjádřete počet chlapců, kteří v aule zůstali na 2. vyučovací hodinu.",
         r"7.2 Určete počet dívek v aule při 1. vyučovací hodině, jestliže po přestávce zůstalo v aule pětkrát více chlapců než dívek."],
    solp=[r"7.1: chlapců bylo $4d$; po odchodu $20$ jich zůstalo $4d-20$.",
          r"7.2: dívek zůstalo $d-10$; z podmínky $4d-20=5\cdot(d-10)$ plyne $4d-20=5d-50$, tedy $d=30$."],
    ans=r"7.1: $4d-20$; 7.2: $30$ dívek",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 8", pts=3, mins=6, diff="3",
    zad=[r"V krychli mají každé dvě sousední stěny jednu společnou hranu. V síti krychle mohou být některé sousední stěny krychle odděleny. Pak tutéž hranu krychle představují dvě různé úsečky sítě (označené tmavými kolečky).",
         r"V každé ze tří sítí krychle (8.1, 8.2, 8.3) je tmavým kolečkem označena jedna z obou úseček představujících tutéž hranu krychle.",
         r"Dalším kolečkem označte druhou z těchto úseček."],
    solp=[r"Síť v představě složíme do krychle. Hraniční úsečka označená kolečkem se při složení ztotožní s jinou hraniční úsečkou sítě — obě dvě představují tutéž hranu krychle. Právě tuto druhou úsečku v každé síti označíme dalším kolečkem.",
          r"Jde o úlohu s nákresovým řešením; hodnotí se správné vyznačení druhé úsečky ve všech třech sítích (8.1–8.3)."],
    ans=r"V každé ze tří sítí (8.1–8.3) se dalším kolečkem vyznačí druhá úsečka představující tutéž hranu krychle (nákresové řešení).",
    svg=fig(5, (100, 368, 525, 458)), fn=FN,
    alt="Tři sítě krychle (8.1, 8.2, 8.3) složené ze čtverců; v každé je jedna hraniční úsečka označena tmavým kolečkem.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "soumernost", "uvazovani", "rysovani"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 9", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží trojúhelník $AXY$ (viz obrázek).",
         r"Bod $A$ je vrchol kosočtverce $ABCD$. Strany $AB$ a $AD$ tohoto kosočtverce leží na polopřímkách $AX$ a $AY$. Výška kosočtverce $ABCD$ je rovna délce úsečky $AY$.",
         r"Sestrojte vrcholy $B$, $C$, $D$ kosočtverce $ABCD$, označte je písmeny a kosočtverec narýsujte."],
    solp=[r"Kosočtverec má všechny strany shodné a jeho výška (vzdálenost dvojice rovnoběžných stran) je rovna $|AY|$.",
          r"Vrchol $B$ leží na polopřímce $AX$, vrchol $D$ na polopřímce $AY$. Strana $DC$ je rovnoběžná se stranou $AB$ ve vzdálenosti $|AY|$ a strana $BC$ je rovnoběžná se stranou $AD$; jejich průsečíkem je vrchol $C$. Podmínka $|AB|=|AD|$ zajistí, že $ABCD$ je kosočtverec.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce kosočtverce $ABCD$ se stranami na polopřímkách $AX$, $AY$ a výškou $|AY|$ (nákresové řešení).",
    svg=fig(6, (130, 170, 280, 290)), fn=FN,
    alt="Trojúhelník AXY: vrchol A vlevo dole, X vpravo dole, Y nahoře.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží tři různé body $A$, $B$ a $O$ (viz obrázek).",
         r"Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Bod $O$ je průsečík výšek tohoto trojúhelníku.",
         r"10.1 Sestrojte a označte písmenem $p$ přímku, na níž leží výška na stranu $AB$.",
         r"10.2 Sestrojte vrchol $C$ trojúhelníku $ABC$, označte jej písmenem a trojúhelník narýsujte."],
    solp=[r"10.1: výška na stranu $AB$ je kolmá k $AB$ a prochází průsečíkem výšek $O$. Přímka $p$ je proto kolmice k přímce $AB$ vedená bodem $O$.",
          r"10.2: vrchol $C$ leží na přímce $p$. Navíc platí $AC\perp BO$ a $BC\perp AO$. Sestrojíme kolmici k přímce $BO$ vedenou bodem $A$; její průsečík s přímkou $p$ je hledaný vrchol $C$.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"$p$ je kolmice k $AB$ vedená bodem $O$; vrchol $C$ je průsečík přímky $p$ s kolmicí k $BO$ vedenou bodem $A$ (nákresové řešení).",
    svg=fig(7, (160, 175, 420, 320)), fn=FN,
    alt="Tři body v rovině: A vlevo dole, B vpravo uprostřed, O nahoře uprostřed.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 11", pts=4, mins=6, diff="3",
    zad=[r"Šest obrazců A–F ve čtvercové síti se skládá ze čtverců a trojúhelníků. Všechny vrcholy obrazců jsou v mřížových bodech (viz obrázek).",
         r"Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).",
         r"11.1 Právě $4$ osy souměrnosti má pouze jeden obrazec.",
         r"11.2 Právě $1$ osu souměrnosti mají pouze $2$ obrazce, a to B a F.",
         r"11.3 Právě $2$ osy souměrnosti mají pouze $2$ obrazce."],
    solp=[r"U každého z obrazců A–F určíme počet os souměrnosti.",
          r"11.1: čtyři osy souměrnosti má jediný z obrazců (čtverec s vepsaným čtvercem), žádný jiný ne — tvrzení je pravdivé (A).",
          r"11.2: dvojice obrazců, které mají právě jednu osu souměrnosti, není tvořena pouze obrazci B a F — tvrzení je nepravdivé (N).",
          r"11.3: právě dvě osy souměrnosti mají právě dva z obrazců — tvrzení je pravdivé (A)."],
    ans=r"11.1: A; 11.2: N; 11.3: A",
    svg=fig(8, (78, 121, 540, 363)), fn=FN,
    alt="Šest obrazců A–F ve čtvercové síti, každý složený ze šedých čtverců a trojúhelníků; posuzuje se počet os souměrnosti.", cap="",
    codes=["zs2", "r9", "soumernost", "planimetrie", "geometrie", "uvazovani"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Na úsečce $AB$ leží bod $D$, na polopřímce $AE$ bod $C$ (viz obrázek). Úsečky $AC$, $CD$ a $BD$ mají stejnou délku $d$. Úhel $ACD$ má velikost $120^\circ$.",
         r"V obrázku je $\alpha$ úhel při vrcholu $A$, $\beta$ úhel při vrcholu $B$ a $\varphi$ úhel mezi polopřímkou $CE$ a úsečkou $CB$.",
         r"Jaký je součet úhlů $\alpha+\beta+\varphi$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Trojúhelník $ACD$ je rovnoramenný ($AC=CD$) s úhlem $120^\circ$ při vrcholu $C$, proto $\alpha=\angle DAC=\frac{180^\circ-120^\circ}{2}=30^\circ$ a $\angle ADC=30^\circ$.",
          r"Úhel $CDB=180^\circ-30^\circ=150^\circ$; trojúhelník $CDB$ je rovnoramenný ($CD=BD$), takže $\beta=\angle DBC=\frac{180^\circ-150^\circ}{2}=15^\circ$ a $\angle DCB=15^\circ$.",
          r"$\angle ACB=120^\circ+15^\circ=135^\circ$; body $A$, $C$, $E$ leží na jedné přímce, proto $\varphi=\angle ECB=180^\circ-135^\circ=45^\circ$.",
          r"$\alpha+\beta+\varphi=30^\circ+15^\circ+45^\circ=90^\circ$."],
    ans=r"A) $90^\circ$",
    opts=[r"A) $90^\circ$", r"B) $85^\circ$", r"C) $80^\circ$", r"D) $75^\circ$", r"E) jiná velikost"],
    svg=fig(9, (85, 128, 300, 235)), fn=FN,
    alt="Úsečka AB s bodem D, polopřímka AE s bodem C; AC=CD=BD=d, úhel ACD je 120°, vyznačeny úhly alfa při A, beta při B a fí u C.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 13", pts=2, mins=3, diff="3",
    zad=[r"Obsah pravoúhlého trojúhelníku $ABC$ (pravý úhel při vrcholu $C$) je $96\ \mathrm{cm}^2$. Délka odvěsny $BC$ je $12\ \mathrm{cm}$ (viz obrázek).",
         r"Jaká je délka přepony $AB$?"],
    solp=[r"Z obsahu $\frac{1}{2}\cdot|BC|\cdot|AC|=96$ plyne $\frac{1}{2}\cdot12\cdot|AC|=96$, tedy $|AC|=16\ \mathrm{cm}$.",
          r"Přepona $|AB|=\sqrt{12^2+16^2}=\sqrt{144+256}=\sqrt{400}=20\ \mathrm{cm}$."],
    ans=r"D) $20\ \mathrm{cm}$",
    opts=[r"A) menší než $15\ \mathrm{cm}$", r"B) $15\ \mathrm{cm}$", r"C) $18\ \mathrm{cm}$", r"D) $20\ \mathrm{cm}$", r"E) větší než $20\ \mathrm{cm}$"],
    svg=fig(9, (382, 498, 530, 582)), fn=FN,
    alt="Pravoúhlý trojúhelník ABC s pravým úhlem při vrcholu C, odvěsna BC svislá o délce 12 cm.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 14", pts=2, mins=4, diff="3",
    zad=[r"Školu navštěvuje $400$ žáků. Každý žák školy se učí anglicky nebo německy, někteří studují dokonce oba jazyky. Anglicky se učí $72\ \%$ žáků školy. Třetina žáků, kteří se učí anglicky, se učí také německy.",
         r"Kolik žáků školy se učí německy?"],
    solp=[r"Anglicky se učí $0{,}72\cdot400=288$ žáků; z nich se oba jazyky učí $\frac{288}{3}=96$ žáků.",
          r"Pouze anglicky se učí $288-96=192$ žáků, takže německy (včetně těch, kdo se učí oba jazyky) se učí $400-192=208$ žáků."],
    ans=r"E) $208$",
    opts=[r"A) $96$", r"B) $112$", r"C) $180$", r"D) $198$", r"E) $208$"],
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "uvazovani", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Ze všech $420$ hotelových pokojů bylo včera $15\ \%$ pokojů obsazených. Dnes je obsazených pokojů o dvě třetiny více než včera. Kolik hotelových pokojů je dnes obsazených?",
         r"15.2 Filip má startovní číslo, jehož třetina je o $9$ větší než jeho čtvrtina. Jaké startovní číslo má Filip?",
         r"15.3 V krabičce bylo $96$ matiček. Pak jsme z krabičky odebrali šestinu matiček a přidali do ní šroubky. Nyní je v krabičce o $50\ \%$ více šroubků než matiček. Kolik šroubků je nyní v krabičce?",
         r"Nabídka: A) $96$; B) $105$; C) $108$; D) $115$; E) $120$; F) jiný výsledek."],
    solp=[r"15.1: včera $0{,}15\cdot420=63$ pokojů; dnes $63+\frac{2}{3}\cdot63=63+42=105$ — \textbf{B}.",
          r"15.2: $\frac{x}{3}=\frac{x}{4}+9\Rightarrow\frac{x}{12}=9\Rightarrow x=108$ — \textbf{C}.",
          r"15.3: po odebrání šestiny zůstalo $96-\frac{96}{6}=96-16=80$ matiček; šroubků je $1{,}5\cdot80=120$ — \textbf{E}."],
    ans=r"15.1: B; 15.2: C; 15.3: E",
    codes=["zs2", "r9", "procenta", "rovnice", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2020 M9I · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"Obdélníková mozaika z bílých a šedých čtverců se tvoří podle následujících pravidel: počet sloupců v obdélníku je o $1$ větší než počet řad; šedý obdélník obklopují bílé čtverce pouze v jedné vrstvě (viz obrázek — mozaiky se $4$ sloupci a $3$ řadami, s $5$ sloupci a $4$ řadami atd.).",
         r"16.1 Vypočtěte, kolik šedých čtverců je v mozaice, která obsahuje celkem $12$ řad.",
         r"16.2 Vypočtěte, kolik šedých čtverců je v mozaice, která má $70$ bílých čtverců.",
         r"16.3 Vypočtěte, kolik bílých čtverců je v mozaice, která má celkem $380$ čtverců (šedých i bílých)."],
    solp=[r"Má-li mozaika $r$ řad, má $r+1$ sloupců. Šedý obdélník uvnitř má rozměry $(r-1)\times(r-2)$, tedy šedých čtverců je $(r-1)(r-2)$. Bílých je $r(r+1)-(r-1)(r-2)=4r-2$.",
          r"16.1: $r=12$: šedých $(12-1)(12-2)=11\cdot10=110$.",
          r"16.2: $4r-2=70\Rightarrow r=18$: šedých $(18-1)(18-2)=17\cdot16=272$.",
          r"16.3: $r(r+1)=380\Rightarrow r=19$; bílých $4\cdot19-2=74$."],
    ans=r"16.1: $110$ šedých čtverců; 16.2: $272$ šedých čtverců; 16.3: $74$ bílých čtverců",
    svg=fig(11, (78, 138, 532, 284)), fn=FN,
    alt="Tři mozaiky tvaru obdélníku ze šedých a bílých čtverců: 4 sloupce a 3 řady, 5 sloupců a 4 řady, 6 sloupců a 5 řad, s naznačením pokračování.", cap="",
    codes=["zs2", "r9", "posloupnosti", "algebra", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9I-2020")
for path, size, names in written:
    print("%s  %d B  (%d úloh)" % (path, size, len(names)))
