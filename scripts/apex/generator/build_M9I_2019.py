# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9I 2019 (ilustrační test, 4leté obory)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9I_2019_TS.pdf"
SRC = "CERMAT – Ilustrační test 2019, matematika 9 (čtyřleté obory)"
CCODE = "M9PID19C0T01"
YR = 2019
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2019 M9I · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte, o kolik je polovina čísla $2{,}5$ větší než číslo $\dfrac{1}{2}$.",
         r"Výsledek uveďte desetinným číslem."],
    solp=[r"Polovina čísla $2{,}5$ je $1{,}25$; číslo $\frac{1}{2}=0{,}5$.",
          r"Rozdíl $1{,}25-0{,}5=0{,}75$."],
    ans=r"$0{,}75$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 2", pts=2, mins=4, diff="2",
    zad=[r"Vypočtěte:",
         r"2.1 \quad $25{,}6:0{,}2-10^2\cdot 0{,}029=$",
         r"2.2 \quad $\dfrac{\sqrt{1{,}2^2}}{0{,}01}-\dfrac{\left(\sqrt{0{,}01}\right)^2}{10}\cdot 3\,600=$"],
    solp=[r"2.1: $25{,}6:0{,}2=128$; $10^2\cdot 0{,}029=100\cdot 0{,}029=2{,}9$; $128-2{,}9=125{,}1$.",
          r"2.2: $\sqrt{1{,}2^2}=1{,}2$, tedy $\frac{1{,}2}{0{,}01}=120$; $\left(\sqrt{0{,}01}\right)^2=0{,}01$, tedy $\frac{0{,}01}{10}\cdot 3\,600=0{,}001\cdot 3\,600=3{,}6$; $120-3{,}6=116{,}4$."],
    ans=r"2.1: $125{,}1$; 2.2: $116{,}4$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{\frac{1}{4}+\frac{2}{3}}{\left(3-\frac{9}{4}\right)\cdot\frac{8}{3}}=$",
         r"3.2 \quad $3:\dfrac{2\cdot 6}{2+6}-\dfrac{12}{3}\cdot\dfrac{5}{8}=$"],
    solp=[r"3.1: čitatel $\frac{1}{4}+\frac{2}{3}=\frac{3}{12}+\frac{8}{12}=\frac{11}{12}$; jmenovatel $\left(3-\frac{9}{4}\right)\cdot\frac{8}{3}=\frac{3}{4}\cdot\frac{8}{3}=2$; $\frac{11}{12}:2=\frac{11}{24}$.",
          r"3.2: $\frac{2\cdot 6}{2+6}=\frac{12}{8}=\frac{3}{2}$, tedy $3:\frac{3}{2}=2$; $\frac{12}{3}\cdot\frac{5}{8}=4\cdot\frac{5}{8}=\frac{5}{2}$; $2-\frac{5}{2}=-\frac{1}{2}$."],
    ans=r"3.1: $\frac{11}{24}$; 3.2: $-\frac{1}{2}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 4", pts=4, mins=7, diff="3",
    zad=[r"Zjednodušte (výsledný výraz nesmí obsahovat závorky):",
         r"4.1 \quad $a-a^2+2-2\cdot(a+1)\cdot(1-a)=$",
         r"4.2 \quad $\left(n-\dfrac{5}{2}\right):2+\left(\dfrac{1}{2}-n\right)^2=$"],
    solp=[r"4.1: $2\cdot(a+1)(1-a)=2\cdot(1-a^2)=2-2a^2$; $a-a^2+2-(2-2a^2)=a-a^2+2-2+2a^2=a^2+a$.",
          r"4.2: $\left(n-\frac{5}{2}\right):2=\frac{n}{2}-\frac{5}{4}$; $\left(\frac{1}{2}-n\right)^2=\frac{1}{4}-n+n^2$; součet $\frac{n}{2}-\frac{5}{4}+\frac{1}{4}-n+n^2=n^2-\frac{n}{2}-1$."],
    ans=r"4.1: $a^2+a$; 4.2: $n^2-\dfrac{n}{2}-1$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $0{,}4+\dfrac{4x}{5}-1=0{,}2x-\dfrac{3}{2}$",
         r"5.2 \quad $\dfrac{3y-1}{3}-\dfrac{5y-2}{6}=\dfrac{3}{4}\,y+2$"],
    solp=[r"5.1: $\frac{4x}{5}=0{,}8x$, takže $0{,}8x-0{,}6=0{,}2x-1{,}5\Rightarrow 0{,}6x=-0{,}9\Rightarrow x=-1{,}5=-\frac{3}{2}$.",
          r"5.2: levá strana $\frac{2(3y-1)-(5y-2)}{6}=\frac{6y-2-5y+2}{6}=\frac{y}{6}$; $\frac{y}{6}=\frac{3}{4}y+2$; vynásobením $12$: $2y=9y+24\Rightarrow -7y=24\Rightarrow y=-\frac{24}{7}$."],
    ans=r"5.1: $x=-\dfrac{3}{2}$; 5.2: $y=-\dfrac{24}{7}$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 6", pts=3, mins=6, diff="3",
    zad=[r"V každém z následujících výpočtů se žádná z číslic $0,1,2,3,4,5,6,7,8,9$ nesmí vyskytnout více než jedenkrát. Do každého prázdného rámečku ($\square$) doplňte takovou číslici, aby byl výpočet správný.",
         r"6.1 \quad $6\;\;3\;-\;\square\;=\;5\;\;\square$",
         r"6.2 \quad (další možnost) \quad $6\;\;3\;-\;\square\;=\;5\;\;\square$",
         r"6.3 \quad $8\;\;4\;\;9\;+\;3\;\;\square\;\;\square\;=\;\square\;\;\square\;\;\square\;\;\square$"],
    solp=[r"6.1: výsledek je tvaru $5\square$, tedy $63-\square=5\square$; volbou $\square=9$ dostaneme $63-9=54$ (číslice $6,3,9,5,4$ jsou různé).",
          r"6.2: jiná možnost je $63-4=59$ (číslice $6,3,4,5,9$ jsou různé).",
          r"6.3: $849+3\square\square$ dá čtyřciferné číslo; volbou $357$ vyjde $849+357=1\,206$ (využity všechny číslice $0$ až $9$).",
          r"Všechna ekvivalentní řešení splňující podmínky jsou možná."],
    ans=r"6.1: $63-9=54$; 6.2: $63-4=59$; 6.3: $849+357=1\,206$",
    codes=["zs2", "r9", "aritmetika", "cisla", "uvazovani", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 7", pts=3, mins=6, diff="3",
    zad=[r"Cukrárna se měla vybavit $4$ stejnými stolky a $20$ stejnými židlemi celkem za $9\,200\ \mathrm{K\check{c}}$. Nakonec se koupily stolky a židle jen za $7\,800\ \mathrm{K\check{c}}$, neboť $1$ stolek a $2$ židle již nebyly na skladě.",
         r"Vypočtěte, kolik Kč stojí",
         r"7.1 \quad $1$ židle;",
         r"7.2 \quad $1$ stolek."],
    solp=[r"Rozdíl cen $9\,200-7\,800=1\,400\ \mathrm{K\check{c}}$ odpovídá $1$ stolku a $2$ židlím: $s+2\check{z}=1\,400$.",
          r"Z $4s+20\check{z}=9\,200$ plyne $s+5\check{z}=2\,300$. Odečtením: $3\check{z}=900\Rightarrow \check{z}=300$; pak $s=1\,400-2\cdot 300=800$.",
          r"7.1: $1$ židle stojí $300\ \mathrm{K\check{c}}$. 7.2: $1$ stolek stojí $800\ \mathrm{K\check{c}}$."],
    ans=r"7.1: $300\ \mathrm{K\check{c}}$; 7.2: $800\ \mathrm{K\check{c}}$",
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 8", pts=3, mins=7, diff="4",
    zad=[r"Cesty v bludišti jsou složeny z rovných úseků (silné čáry), všechny křižovatky jsou pravoúhlé. Čísla představují délky úseků v metrech. Přímá vzdálenost bodů $A$, $B$ je $13\ \mathrm{m}$.",
         r"Vyznačená cesta z bodu $A$ do bodu $B$ vede po úsecích: vodorovně $8\ \mathrm{m}$, svisle dolů $2\ \mathrm{m}$, vodorovně $4\ \mathrm{m}$ a nakonec svisle dolů do bodu $B$.",
         r"Vyznačená cesta z bodu $A$ do bodu $C$ vede po úsecích: svisle dolů $8\ \mathrm{m}$, vodorovně $4\ \mathrm{m}$, svisle dolů $8\ \mathrm{m}$, vodorovně $4\ \mathrm{m}$, svisle nahoru $4\ \mathrm{m}$ a vodorovně $8\ \mathrm{m}$ do bodu $C$ (všechny vodorovné úseky téhož směru).",
         r"Vypočtěte v metrech",
         r"8.1 \quad délku vyznačené cesty z bodu $A$ do bodu $B$;",
         r"8.2 \quad přímou vzdálenost bodů $A$, $C$."],
    solp=[r"8.1: vodorovné úseky cesty $A\to B$ mají součet $8+4=12\ \mathrm{m}$, svislé úseky součet $s$. Protože přímá vzdálenost je $13\ \mathrm{m}$ a $13=\sqrt{12^2+5^2}$, je celkový svislý pokles $5\ \mathrm{m}$. Délka cesty $=12+5=17\ \mathrm{m}$.",
          r"8.2: vodorovné posunutí z $A$ do $C$ je $4+4+8=16\ \mathrm{m}$, svislé posunutí je $8+8-4=12\ \mathrm{m}$. Přímá vzdálenost $=\sqrt{16^2+12^2}=\sqrt{256+144}=\sqrt{400}=20\ \mathrm{m}$."],
    ans=r"8.1: $17\ \mathrm{m}$; 8.2: $20\ \mathrm{m}$",
    codes=["zs2", "r9", "planimetrie", "geometrie", "vypocet", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 9", pts=3, mins=7, diff="4",
    zad=[r"Na přímce $p$ leží bod $A$ a mimo ni bod $C$ (viz obrázek).",
         r"Body $A$ a $C$ jsou vrcholy rovnoběžníku $ABCD$, jehož úhlopříčka $BD$ je dvakrát delší než úhlopříčka $AC$. Jeden ze zbývajících vrcholů $B$, $D$ tohoto rovnoběžníku leží na přímce $p$.",
         r"Sestrojte a označte chybějící vrcholy $B$, $D$ rovnoběžníku $ABCD$ a rovnoběžník narýsujte. Najděte všechna řešení."],
    solp=[r"Úhlopříčky rovnoběžníku se navzájem půlí; jejich průsečík $S$ je střed úsečky $AC$. Protože $|BD|=2\,|AC|$, je $|SB|=|SD|=\frac{|BD|}{2}=|AC|$.",
          r"Vrchol na přímce $p$ (např. $B$) tedy leží na $p$ a zároveň na kružnici se středem $S$ a poloměrem $|AC|$ — sestrojíme jej jako průsečík. Druhý vrchol $D$ je s ním souměrný podle středu $S$.",
          r"Podle počtu průsečíků přímky $p$ s kružnicí (obvykle dva) má úloha odpovídající počet řešení."],
    ans=r"Konstrukce rovnoběžníku $ABCD$: $S$ je střed $AC$, vrcholy $B$, $D$ leží na přímce $p$ ve vzdálenosti $|AC|$ od $S$ a jsou souměrné podle $S$.",
    svg=fig(5, (100, 222, 492, 415)), fn=FN,
    alt="Na přímce p leží bod A (vyznačen ryskou) a mimo přímku p leží bod C (vyznačen křížkem).", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 10", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží trojúhelník $ABC$ (viz obrázek). Všechny vrcholy trojúhelníku $ABC$ leží na kružnici $k$.",
         r"10.1 \quad Sestrojte kružnici $k$ a vyznačte její střed $S$.",
         r"10.2 \quad Bod $C$ je vrchol čtverce $CDEF$. Zbývající vrcholy $D$, $E$, $F$ čtverce $CDEF$ leží rovněž na kružnici $k$. Sestrojte čtverec $CDEF$ a označte jeho vrcholy."],
    solp=[r"10.1: střed $S$ kružnice opsané je průsečík os stran trojúhelníku (osy $AB$ a $BC$); kružnice $k$ má poloměr $|SC|$.",
          r"10.2: čtverec vepsaný do kružnice $k$ má úhlopříčky procházející středem $S$. Vrchol $E$ je souměrný s $C$ podle $S$ (úsečka $CE$ je průměr); vrcholy $D$, $F$ leží na průměru kolmém k $CE$ vedeném bodem $S$."],
    ans=r"Konstrukce kružnice opsané ($S$ = průsečík os stran) a čtverce $CDEF$ vepsaného do $k$ (úhlopříčky $CE$, $DF$ jsou navzájem kolmé průměry se středem $S$).",
    svg=fig(6, (160, 198, 417, 405)), fn=FN,
    alt="Trojúhelník ABC s vrcholem A vlevo dole, vrcholem B vpravo dole a vrcholem C vlevo nahoře.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 11", pts=4, mins=8, diff="4",
    zad=[r"První obrazec je tvořen dvěma bílými čtverci a jedním tmavým čtvercem (viz obrázek). Obvod bílého čtverce je dvakrát menší než obvod tmavého čtverce. Obvod celého prvního obrazce je $96\ \mathrm{cm}$.",
         r"Druhý i třetí obrazec se skládá ze dvou prvních obrazců.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 \quad Obvod jednoho tmavého čtverce je $48\ \mathrm{cm}$.",
         r"11.2 \quad Obvod celého druhého obrazce je $192\ \mathrm{cm}$.",
         r"11.3 \quad Obvod celého třetího obrazce je o $48\ \mathrm{cm}$ větší než obvod celého druhého obrazce."],
    solp=[r"Nechť bílý čtverec má stranu $a$; obvod tmavého je dvakrát větší, proto tmavý má stranu $2a$. Obvod prvního obrazce je $12a=96\Rightarrow a=8\ \mathrm{cm}$, tmavý čtverec má stranu $16\ \mathrm{cm}$.",
          r"11.1: obvod tmavého čtverce $=4\cdot 16=64\ \mathrm{cm}\ne 48\ \mathrm{cm}$ — \textbf{N}.",
          r"11.2: druhý obrazec má obvod $16a=128\ \mathrm{cm}\ne 192\ \mathrm{cm}$ — \textbf{N}.",
          r"11.3: třetí obrazec má obvod $22a=176\ \mathrm{cm}$; $176-128=48\ \mathrm{cm}$ — \textbf{A}."],
    ans=r"11.1: N; 11.2: N; 11.3: A",
    svg=fig(7, (75, 165, 515, 278)), fn=FN,
    alt="První, druhý a třetí obrazec složené z bílých a tmavých (šedých) čtverců; tmavý čtverec má dvojnásobnou stranu než bílý.", cap="",
    codes=["zs2", "r9", "obvod", "planimetrie", "geometrie", "uvazovani", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Přímky $a$, $b$, $c$ se protínají v jednom bodě, přímka $d$ tímto bodem neprochází. Přímka $a$ je vodorovná. Nad přímkou $a$ svírá levá část přímky $a$ s přímkou $b$ úhel $\alpha$, přímka $b$ s přímkou $c$ úhel $15^\circ$ a přímka $c$ s pravou částí přímky $a$ úhel $2\alpha$.",
         r"Přímka $d$ protíná přímku $a$ tak, že s ní svírá úhel $\alpha$. Úhel $\beta$ je úhel, který spolu svírají přímky $b$ a $d$ v jejich průsečíku pod přímkou $a$.",
         r"Jaká je velikost úhlu $\beta$? Úhly neměřte, ale vypočtěte."],
    solp=[r"Úhly nad přímkou $a$ v jejich společném bodě dávají $\alpha+15^\circ+2\alpha=180^\circ\Rightarrow 3\alpha=165^\circ\Rightarrow \alpha=55^\circ$.",
          r"Uvažme trojúhelník ohraničený přímkami $a$, $b$, $d$. Úhel u průsečíku $a$ a $d$ je $\alpha=55^\circ$. Úhel u společného bodu přímek $a$, $b$ (mezi pravou částí $a$ a přímkou $b$) je vrcholový k úhlu $\alpha$, tedy rovněž $55^\circ$.",
          r"Proto $\beta=180^\circ-55^\circ-55^\circ=70^\circ$."],
    ans=r"D) $70^\circ$",
    opts=[r"A) $55^\circ$", r"B) $60^\circ$", r"C) $65^\circ$", r"D) $70^\circ$", r"E) jiná velikost"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 13", pts=2, mins=4, diff="3",
    zad=[r"Uvnitř papírového kvádru je ukryto několik dřevěných krychliček s hranou délky $3{,}9\ \mathrm{cm}$. Síť tohoto kvádru je zakreslena ve čtvercové síti se stranou čtverce $2\ \mathrm{cm}$; kvádr má rozměry $6\ \mathrm{cm}$, $8\ \mathrm{cm}$ a $4\ \mathrm{cm}$.",
         r"Jaký je největší možný počet dřevěných krychliček, které mohou být ukryty uvnitř papírového kvádru?"],
    solp=[r"Podél hrany $6\ \mathrm{cm}$ se vejde $\lfloor 6:3{,}9\rfloor=1$ krychlička, podél hrany $8\ \mathrm{cm}$ $\lfloor 8:3{,}9\rfloor=2$ krychličky a podél hrany $4\ \mathrm{cm}$ $\lfloor 4:3{,}9\rfloor=1$ krychlička.",
          r"Celkem se vejde nejvýše $1\cdot 2\cdot 1=2$ krychličky, což je méně než $3$."],
    ans=r"A) méně než $3$",
    opts=[r"A) méně než $3$", r"B) $3$", r"C) $4$", r"D) $6$", r"E) jiný počet"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Graf udává počet prodaných zájezdů v jednotlivých měsících: leden $120$, únor $60$, březen $120$, duben $60$, květen $40$, červen $20$, červenec $10$.",
         r"Ve kterém měsíci bylo prodáno o polovinu zájezdů méně než o měsíc dříve a současně o polovinu zájezdů více než o měsíc později?"],
    solp=[r"Hledáme měsíc, jehož hodnota je polovinou hodnoty předchozího měsíce a zároveň je o polovinu větší než hodnota následujícího měsíce.",
          r"Duben: $60=\frac{120}{2}$ (o polovinu méně než březen) a zároveň $60=1{,}5\cdot 40$, tj. o polovinu více než květen ($40$). Podmínku splňuje duben."],
    ans=r"C) v dubnu",
    opts=[r"A) v únoru", r"B) v březnu", r"C) v dubnu", r"D) v květnu", r"E) v červnu"],
    codes=["zs2", "r9", "grafy", "aritmetika", "uvazovani", "vyber", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 15", pts=6, mins=9, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 \quad Firma očekávala, že získá $120$ zakázek, ale nakonec se jí podařilo získat $180$ zakázek. O kolik procent firma překročila své očekávání?",
         r"15.2 \quad V katalogu je cena výrobku $1\,000\ \mathrm{K\check{c}}$, ale v prodejně je o $20\ \%$ nižší. Na internetu se výrobek prodává za $480\ \mathrm{K\check{c}}$. O kolik procent je cena výrobku na internetu nižší než v prodejně?",
         r"15.3 \quad Spolek seniorů má tři zájmové kluby – šachy, turistiku a vaření; každý člen navštěvuje právě jeden klub. Šachy navštěvuje $15$ členů, turistiku $60\ \%$ všech členů a vaření $45$ členů. Ve spolku je celkem $84$ žen. Kolik procent všech členů spolku tvoří muži?",
         r"Nabídka: A) (o) méně než $40\ \%$; B) (o) $40\ \%$; C) (o) $44\ \%$; D) (o) $45\ \%$; E) (o) $50\ \%$; F) (o) více než $50\ \%$."],
    solp=[r"15.1: $\frac{180-120}{120}=\frac{60}{120}=50\ \%$ — \textbf{E}.",
          r"15.2: cena v prodejně $=1\,000\cdot 0{,}8=800\ \mathrm{K\check{c}}$; $\frac{800-480}{800}=\frac{320}{800}=40\ \%$ — \textbf{B}.",
          r"15.3: šachy a vaření mají $15+45=60$ členů, což je $40\ \%$ všech (turistika tvoří $60\ \%$); celkem $\frac{60}{0{,}4}=150$ členů. Mužů je $150-84=66$; $\frac{66}{150}=44\ \%$ — \textbf{C}."],
    ans=r"15.1: E; 15.2: B; 15.3: C",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9I · úloha 16", pts=4, mins=8, diff="5",
    zad=[r"Na kruhové autodráze jezdila v sousedních drahách dvě autíčka – první ve vnitřní dráze, druhé ve vnější. Obě autíčka vystartovala současně z jedné startovní čáry. První autíčko ujelo každá $4$ kola za stejnou dobu, za kterou druhé autíčko ujelo $3$ kola. Během jízdy autíčka neměnila svou rychlost.",
         r"16.1 \quad Obě autíčka vystartovala stejným směrem. První autíčko ujelo prvních $10$ kol. Určete, kolikrát během této jízdy dostihlo druhé autíčko.",
         r"16.2 \quad Obě autíčka vystartovala stejným směrem. Druhé autíčko ujelo prvních $50$ kol. Určete, kolikrát ho během této jízdy dostihlo první autíčko.",
         r"16.3 \quad Druhé autíčko vystartovalo v opačném směru než první autíčko. Druhé autíčko ujelo prvních $5$ kol. Určete, kolikrát se během této jízdy obě autíčka minula. (Poprvé se obě autíčka minula hned po startu.)"],
    solp=[r"Poměr počtu ujetých kol je první$\,$:$\,$druhé $=4:3$.",
          r"16.1: když první ujede $10$ kol, druhé ujede $10\cdot\frac{3}{4}=7{,}5$ kola. Při stejném směru dostihne první druhé po každém získaném celém kole: $\lfloor 10-7{,}5\rfloor=\lfloor 2{,}5\rfloor=2$ — \textbf{2krát}.",
          r"16.2: když druhé ujede $50$ kol, první ujede $50\cdot\frac{4}{3}=66\frac{2}{3}$ kola; rozdíl $66\frac{2}{3}-50=16\frac{2}{3}$, tedy $\lfloor 16\frac{2}{3}\rfloor=16$ — \textbf{16krát}.",
          r"16.3: při opačných směrech se autíčka minou vždy, když součet jimi ujetých kol vzroste o celé kolo. Když druhé ujede $5$ kol, první ujede $5\cdot\frac{4}{3}=6\frac{2}{3}$ kola; součet je $5+6\frac{2}{3}=11\frac{2}{3}$. Minutí nastanou pro součty $0,1,2,\dots,11$ (první hned po startu) — celkem \textbf{12krát}."],
    ans=r"16.1: 2krát; 16.2: 16krát; 16.3: 12krát",
    codes=["zs2", "r9", "pomer", "aritmetika", "posloupnosti", "uvazovani", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9I-2019")
for path, size, names in written:
    print(path, size, "bajtů,", len(names), "úloh")
