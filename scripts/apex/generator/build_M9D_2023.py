# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9D 2023 (druhý náhradní termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9D_2023_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)"
CCODE = "M9PDD23C0T04"
YR = 2023
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2023 M9D · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Hmotnosti dvou závaží jsou v poměru $3:5$ a liší se o $600\ \mathrm{g}$.",
         r"Vypočtěte v gramech hmotnost lehčího závaží."],
    solp=[r"Rozdíl je $5-3=2$ díly $=600\ \mathrm{g}$, tedy $1$ díl $=300\ \mathrm{g}$; lehčí závaží má $3$ díly $=900\ \mathrm{g}$."],
    ans=r"$900\ \mathrm{g}$",
    codes=["zs2", "r9", "pomer", "aritmetika", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 2", pts=2, mins=3, diff="3",
    zad=[r"Na číselné ose je vyznačeno $13$ bodů, které oddělují $12$ stejných dílků. V jednom z těchto bodů je číslo $20$ a body A, B, C představují tři kladná čísla (viz obrázek). Číslo v bodě C je součtem čísla v bodě A a čísla v bodě B.",
         r"Určete číslo v bodě 2.1 C, 2.2 B."],
    solp=[r"Označme délku dílku $d$. Z obrázku: A leží $2$ dílky vlevo od $20$ ($A=20-2d$), B leží $2$ dílky vpravo ($B=20+2d$), C leží $5$ dílků vpravo ($C=20+5d$).",
          r"Podmínka $C=A+B$: $20+5d=(20-2d)+(20+2d)=40\Rightarrow5d=20\Rightarrow d=4$.",
          r"Tedy $C=20+5\cdot4=40$ a $B=20+2\cdot4=28$ (a $A=12$)."],
    ans=r"2.1: C $=40$; 2.2: B $=28$",
    svg=fig(1, (66, 278, 470, 332)), fn=FN,
    alt="Číselná osa se 13 body oddělujícími 12 stejných dílků; v jednom bodě je číslo 20 a jsou vyznačeny body A, B, C.", cap="",
    codes=["zs2", "r9", "cisla", "aritmetika", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{\frac{2}{3}-1}{\frac{8}{9}}=$",
         r"3.2 \quad $2\cdot\dfrac{1}{6}-\dfrac{3}{8}\cdot4=$",
         r"3.3 \quad $\dfrac{\frac{6}{7}-\frac{9}{14}}{\frac{8}{7}+\frac{6}{7}:\frac{3}{2}}=$"],
    solp=[r"3.1: $\frac{\frac{2}{3}-1}{\frac{8}{9}}=\frac{-\frac{1}{3}}{\frac{8}{9}}=-\frac{1}{3}\cdot\frac{9}{8}=-\frac{3}{8}$.",
          r"3.2: $\frac{1}{3}-\frac{3}{2}=\frac{2}{6}-\frac{9}{6}=-\frac{7}{6}$.",
          r"3.3: čitatel $\frac{12}{14}-\frac{9}{14}=\frac{3}{14}$; jmenovatel $\frac{8}{7}+\frac{6}{7}\cdot\frac{2}{3}=\frac{8}{7}+\frac{4}{7}=\frac{12}{7}$; $\frac{3}{14}:\frac{12}{7}=\frac{3}{14}\cdot\frac{7}{12}=\frac{1}{8}$."],
    ans=r"3.1: $-\frac{3}{8}$; 3.2: $-\frac{7}{6}$; 3.3: $\frac{1}{8}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(0{,}3x+0{,}5)^2=$",
         r"4.2 Rozložte na součin podle vzorce: $49-(-4a)^2=$",
         r"4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $n\cdot(2n-1)-(-2n-n)\cdot(3n+2)+(1-2n)\cdot(1+2n)=$"],
    solp=[r"4.1: $0{,}09x^2+0{,}3x+0{,}25$.",
          r"4.2: $49-16a^2=(7+4a)\cdot(7-4a)$.",
          r"4.3: $2n^2-n-(-3n)(3n+2)+(1-4n^2)=2n^2-n+9n^2+6n+1-4n^2=7n^2+5n+1$."],
    ans=r"4.1: $0{,}09x^2+0{,}3x+0{,}25$; 4.2: $(7+4a)(7-4a)$; 4.3: $7n^2+5n+1$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $\dfrac{2-x}{2}+2x=2{,}5x-3$",
         r"5.2 \quad $3\cdot\dfrac{y+1}{2}-\dfrac{y}{3}=\dfrac{3}{2}\cdot\dfrac{2y-3}{3}+\dfrac{3}{2}$"],
    solp=[r"5.1: vynásobíme $2$: $(2-x)+4x=5x-6\Rightarrow2+3x=5x-6\Rightarrow8=2x\Rightarrow x=4$.",
          r"5.2: levá strana $\frac{9(y+1)-2y}{6}=\frac{7y+9}{6}$; pravá $\frac{2y-3}{2}+\frac{3}{2}=\frac{2y}{2}=y$; $\frac{7y+9}{6}=y\Rightarrow7y+9=6y\Rightarrow y=-9$."],
    ans=r"5.1: $x=4$; 5.2: $y=-9$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 6", pts=3, mins=5, diff="3",
    zad=[r"V pátek, v sobotu a v neděli se na mýtině vysazovaly stromy. V sobotu bylo vysázeno o třetinu více stromů než v pátek. V neděli bylo vysázeno dokonce o $60\ \%$ více stromů než v pátek. Počet stromů vysázených v pátek označíme $p$.",
         r"6.1 Vyjádřete výrazem s proměnnou $p$ počet stromů vysázených v sobotu.",
         r"6.2 Vyjádřete výrazem s proměnnou $p$ počet stromů vysázených v neděli.",
         r"6.3 V pátek bylo vysázeno o $290$ stromů méně než v obou zbývajících dnech dohromady. Vypočtěte, kolik stromů bylo vysázeno v pátek."],
    solp=[r"6.1: sobota $=p+\frac{1}{3}p=\frac{4}{3}p$.",
          r"6.2: neděle $=p+0{,}6p=1{,}6p=\frac{8}{5}p$.",
          r"6.3: $\left(\frac{4}{3}p+\frac{8}{5}p\right)-p=290\Rightarrow p\left(\frac{20}{15}+\frac{24}{15}-\frac{15}{15}\right)=290\Rightarrow\frac{29}{15}p=290\Rightarrow p=150$."],
    ans=r"6.1: $\frac{4}{3}p$; 6.2: $\frac{8}{5}p$; 6.3: $150$ stromů",
    codes=["zs2", "r9", "vyrazy", "rovnice", "procenta", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 7", pts=3, mins=5, diff="4",
    zad=[r"Na parkovišti je přesně $105$ parkovacích míst pro osobní auta. Zaparkuje-li na parkovišti autobus, obsadí vždy $4$ parkovací místa pro osobní auta. (Parkoviště tedy zcela zaplní např. $101$ osobních aut a jeden autobus.)",
         r"7.1 Na zcela zaplněném parkovišti je počet osobních aut stejný jako počet autobusů. Vypočtěte, kolik je na parkovišti osobních aut.",
         r"7.2 Na zcela zaplněném parkovišti je osobních aut o čtvrtinu více než autobusů. Vypočtěte, kolik je na parkovišti autobusů."],
    solp=[r"7.1: nechť aut $=$ autobusů $=n$; auta zaberou $n$ míst, autobusy $4n$ míst: $n+4n=105\Rightarrow5n=105\Rightarrow n=21$ osobních aut.",
          r"7.2: nechť autobusů $=b$, aut $=\frac{5}{4}b$; $\frac{5}{4}b+4b=105\Rightarrow\frac{21}{4}b=105\Rightarrow b=20$ autobusů (a $25$ aut)."],
    ans=r"7.1: $21$ osobních aut; 7.2: $20$ autobusů",
    codes=["zs2", "r9", "rovnice", "aritmetika", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 8", pts=4, mins=6, diff="4",
    zad=[r"Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary A, B, C; v každém je každý tmavý čtverec označen číslem (viz obrázek). Z každého útvaru vytvoříme odebráním jediného tmavého čtverce nový útvar, který je osově souměrný podle některé osy (svislé, vodorovné nebo šikmé). Z útvaru A lze vytvořit osově souměrný útvar odebráním čtverce $2$, nebo odebráním čtverce $8$.",
         r"Určete číslo čtverce, jehož odebráním vytvoříme osově souměrný útvar 8.1 z útvaru B, 8.2 z útvaru C. V každé části najděte obě řešení."],
    solp=[r"8.1: útvar B je osově souměrný po odebrání čtverce $6$, nebo čtverce $10$.",
          r"8.2: útvar C je osově souměrný po odebrání čtverce $1$, nebo čtverce $9$."],
    ans=r"8.1: čtverec $6$ nebo $10$; 8.2: čtverec $1$ nebo $9$",
    svg=fig(4, (66, 128, 595, 272)), fn=FN,
    alt="Ve čtvercové síti tři útvary A, B, C složené z tmavých čtverců, každý tmavý čtverec je označen číslem.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "soumernost", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 9", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží body P, Q, R a přímka $a$ (viz obrázek).",
         r"Na přímce $a$ leží strana AB čtverce ABCD. Dva ze tří bodů P, Q, R leží uvnitř dvou různých stran tohoto čtverce a třetí bod leží vně čtverce ABCD.",
         r"Sestrojte všechny vrcholy čtverce ABCD, označte je písmeny a čtverec narýsujte. Najděte všechna řešení."],
    solp=[r"Dvojice bodů ležících na stranách čtverce určuje polohu čtverce: strana AB leží na přímce $a$, protilehlá strana DC je s ní rovnoběžná ve vzdálenosti rovné straně čtverce, boční strany jsou k $a$ kolmé.",
          r"Vyzkoušíme, které dva z bodů P, Q, R mohou ležet uvnitř stran čtverce (jeden na některé straně, druhý na jiné) tak, aby třetí bod ležel vně; podle toho sestrojíme čtverec. Jde o konstrukční úlohu — hledáme všechna řešení; hodnotí se přesnost a úplnost."],
    ans=r"Konstrukce čtverce ABCD (AB na přímce $a$, dva z bodů P, Q, R uvnitř dvou stran, třetí vně); nutno nalézt všechna řešení.",
    svg=fig(5, (66, 90, 595, 330)), fn=FN,
    alt="V rovině leží body P, Q, R a přímka a.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 10", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží přímky $b$, $c$ a na přímce $b$ leží bod A (viz obrázek).",
         r"Bod A je vrchol trojúhelníku ABC s pravým úhlem při vrcholu A. Na přímce $b$ leží vrchol B a na přímce $c$ leží vrchol C tohoto trojúhelníku. Velikost vnitřního úhlu trojúhelníku ABC při vrcholu C je $40^\circ$.",
         r"Sestrojte vrcholy B, C trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení."],
    solp=[r"Vrchol B leží na přímce $b$. Rameno AC je kolmé k AB (pravý úhel při A), tedy kolmé k přímce $b$; vrchol C je průsečík této kolmice (vedené bodem A) s přímkou $c$. Podmínku $|\angle ACB|=40^\circ$ využijeme k umístění B (např. přenesením úhlu $40^\circ$ při C, nebo $50^\circ$ při B).",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce, včetně nalezení všech řešení."],
    ans=r"Konstrukce pravoúhlého trojúhelníku ABC (pravý úhel při A, B na $b$, C na $c$, $\angle C=40^\circ$).",
    svg=fig(6, (66, 90, 595, 330)), fn=FN,
    alt="V rovině leží přímky b, c a na přímce b leží bod A.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Každý rok pracují v parku jednak brigádníci, kteří tam pracovali v předchozím roce, jednak nově přijatí brigádníci. Na konci každého roku někteří z parku odcházejí. Graf udává počty brigádníků v letech 2018–2022 (tři údaje chybí). Např. v roce 2022 pracovalo $9$ brigádníků z předchozího roku a $6$ nově přijatých; z těchto $15$ jich $8$ na konci roku odešlo.",
         r"Z grafu (z předchozího roku / nově přijatí / na konci roku odešli): 2018: $14$ / $10$ / $8$; \ 2019: chybí / $4$ / $7$; \ 2020: $13$ / chybí / $3$; \ 2021: $16$ / $5$ / chybí; \ 2022: $9$ / $6$ / $8$.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 V roce 2019 pracovalo v parku $16$ brigádníků, kteří tam pracovali i v roce 2018.",
         r"11.2 V roce 2020 pracovalo v parku méně než $7$ nově přijatých brigádníků.",
         r"11.3 Na konci roku 2021 z parku odešlo více než $12$ brigádníků."],
    solp=[r"Počet, kdo přejde do dalšího roku $=$ celkový počet daného roku $-$ počet, kdo odešel.",
          r"2018: celkem $14+10=24$, odešlo $8$, přejde $16$. Tedy v roce 2019 je z předchozího roku $16$ (chybějící údaj).",
          r"2019: celkem $16+4=20$, odešlo $7$, přejde $13$ (souhlasí s údajem $13$ pro 2020).",
          r"2020: přejde do 2021 musí být $16$ (údaj 2021); $16=(13+\text{nově})-3\Rightarrow$ nově $=6$.",
          r"2021: celkem $16+5=21$; do 2022 přejde $9$ (údaj), tedy odešlo $21-9=12$.",
          r"11.1: z předchozího roku 2019 $=16$ — \textbf{A}. 11.2: nově 2020 $=6<7$ — \textbf{A}. 11.3: odešlo 2021 $=12$, ne více než $12$ — \textbf{N}."],
    ans=r"11.1: A; 11.2: A; 11.3: N",
    codes=["zs2", "r9", "grafy", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 12", pts=2, mins=3, diff="3",
    zad=[r"Velký obdélník lze rozdělit na dva shodné menší obdélníky nebo na dva čtverce (viz obrázek). Obvod jednoho z menších obdélníků je $30\ \mathrm{cm}$.",
         r"Jaký je obvod velkého obdélníku?"],
    solp=[r"Rozdělení na dva čtverce znamená, že velký obdélník má rozměry $2s\times s$ (dva čtverce o straně $s$). Menší obdélník (rozdělení na polovinu druhým směrem) má rozměry $2s\times\frac{s}{2}$; jeho obvod $2\left(2s+\frac{s}{2}\right)=5s=30\Rightarrow s=6\ \mathrm{cm}$.",
          r"Velký obdélník má rozměry $12\times6\ \mathrm{cm}$, obvod $2(12+6)=36\ \mathrm{cm}$."],
    ans=r"B) $36\ \mathrm{cm}$",
    opts=[r"A) menší než $36\ \mathrm{cm}$", r"B) $36\ \mathrm{cm}$", r"C) $40\ \mathrm{cm}$", r"D) $60\ \mathrm{cm}$", r"E) větší než $60\ \mathrm{cm}$"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Přímka $p$ prochází vrcholy A, B trojúhelníku ABC, jehož vnitřní úhly mají velikosti $\alpha$, $\beta$, $\gamma$. Bodem B prochází rovnoběžka se stranou AC (viz obrázek). U vrcholu B jsou vyznačeny úhly $30^\circ$ (mezi rovnoběžkou a stranou BA) a $2\beta+\gamma$ (vnější úhel při B).",
         r"Jaká je velikost úhlu $\gamma$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Rovnoběžka bodem B se stranou AC a příčka AB dávají střídavé úhly: $\alpha=30^\circ$.",
          r"Úhel $2\beta+\gamma$ je vnější úhel při B, tedy $2\beta+\gamma=180^\circ-\beta\Rightarrow3\beta+\gamma=180^\circ$.",
          r"Ze součtu úhlů $\alpha+\beta+\gamma=180^\circ$ a $\alpha=30^\circ$ plyne $\beta+\gamma=150^\circ$.",
          r"Odečtením: $2\beta=30^\circ\Rightarrow\beta=15^\circ$, tedy $\gamma=150^\circ-15^\circ=135^\circ$."],
    ans=r"C) $135^\circ$",
    opts=[r"A) $115^\circ$", r"B) $120^\circ$", r"C) $135^\circ$", r"D) $140^\circ$", r"E) $150^\circ$"],
    svg=fig(8, (215, 58, 595, 222)), fn=FN,
    alt="Trojúhelník ABC s přímkou p procházející vrcholy A, B a rovnoběžkou se stranou AC vedenou bodem B; vyznačené úhly 30° a 2β+γ u vrcholu B.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 14", pts=2, mins=4, diff="5",
    zad=[r"Kvádr s podstavou o rozměrech $6\ \mathrm{cm}$ a $8\ \mathrm{cm}$ a výškou $10\ \mathrm{cm}$ lze dvěma svislými úhlopříčnými řezy rozdělit na čtyři trojboké hranoly s výškou $10\ \mathrm{cm}$. Odebráním jednoho z trojbokých hranolů vznikne z kvádru pětiboký hranol (viz obrázek vpravo).",
         r"O kolik cm$^2$ se liší povrch pětibokého hranolu a povrch původního kvádru?"],
    solp=[r"Odebraný trojboký hranol má základnu na straně délky $8\ \mathrm{cm}$; úhlopříčka podstavy $6\times8$ je $\sqrt{6^2+8^2}=10\ \mathrm{cm}$, poloviny úhlopříček (řezné hrany) měří $5\ \mathrm{cm}$.",
          r"Ztratíme boční stěnu $8\times10=80\ \mathrm{cm}^2$ a z podstavy i horní stěny po trojúhelníku o obsahu $\frac{1}{2}\cdot8\cdot3=12\ \mathrm{cm}^2$, tedy $2\cdot12=24\ \mathrm{cm}^2$.",
          r"Přibudou dvě řezné stěny $5\times10=50\ \mathrm{cm}^2$, tj. $2\cdot50=100\ \mathrm{cm}^2$.",
          r"Změna povrchu $=100-80-24=-4\ \mathrm{cm}^2$; povrchy se liší o $4\ \mathrm{cm}^2$."],
    ans=r"A) o $4\ \mathrm{cm}^2$",
    opts=[r"A) o $4\ \mathrm{cm}^2$", r"B) o $16\ \mathrm{cm}^2$", r"C) o $24\ \mathrm{cm}^2$", r"D) o $30\ \mathrm{cm}^2$", r"E) o jiný počet cm$^2$"],
    svg=fig(8, (250, 425, 595, 575)), fn=FN,
    alt="Kvádr 6 cm × 8 cm × 10 cm a pětiboký hranol vzniklý odebráním jednoho ze čtyř trojbokých hranolů.", cap="",
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Letos se na gymnázium přihlásilo $420$ uchazečů, což je o $40\ \%$ více, než se jich přihlásilo loni. Kolik uchazečů se přihlásilo loni?",
         r"15.2 On-line kurzu českého jazyka se zúčastnilo $180$ žáků, což je o $25\ \%$ méně, než se jich zúčastnilo on-line kurzu matematiky. Kolik žáků se zúčastnilo kurzu matematiky?",
         r"15.3 Včera navštívilo plavecký bazén celkem $680$ dospělých, mezi nimiž bylo mužů o $30\ \%$ méně než žen. Kolik mužů včera navštívilo bazén?",
         r"Nabídka: A) méně než $240$; B) $240$; C) $260$; D) $280$; E) $300$; F) více než $300$."],
    solp=[r"15.1: $420:1{,}4=300$ — \textbf{E}.",
          r"15.2: $180:0{,}75=240$ — \textbf{B}.",
          r"15.3: muži $=0{,}7\cdot$ ženy; $0{,}7z+z=680\Rightarrow1{,}7z=680\Rightarrow z=400$, mužů $280$ — \textbf{D}."],
    ans=r"15.1: E; 15.2: B; 15.3: D",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2023 M9D · úloha 16", pts=4, mins=6, diff="4",
    zad=[r"Obrazce tvaru trojúhelníku se sestavují skládáním šedých trojúhelníků do pater (viz obrázek). Šedé trojúhelníky mají ve vrcholech puntíky a na stranách stejně dlouhé úsečky. V prvním obrazci je jeden šedý trojúhelník a každý další obrazec má o jedno patro více. Tabulka: patra $1/2/3$, šedé trojúhelníky $1/3/6$, puntíky $3/6/10$, úsečky $3/9/18$.",
         r"16.1 Určete počet úseček v obrazci, který má $5$ pater.",
         r"16.2 Počet úseček v posledním a předposledním obrazci se liší o $96$. Určete, o kolik se liší počet puntíků v těchto obrazcích.",
         r"16.3 V jednom obrazci je $300$ puntíků. Určete počet úseček v následujícím obrazci."],
    solp=[r"Pro $n$ pater: úsečky $=3\cdot\frac{n(n+1)}{2}$, puntíky $=\frac{(n+1)(n+2)}{2}$.",
          r"16.1: $3\cdot\frac{5\cdot6}{2}=3\cdot15=45$ úseček.",
          r"16.2: rozdíl úseček $=3n=96\Rightarrow n=32$; rozdíl puntíků $=n+1=33$.",
          r"16.3: $\frac{(n+1)(n+2)}{2}=300\Rightarrow(n+1)(n+2)=600=24\cdot25\Rightarrow n=23$; následující obrazec má $24$ pater: úsečky $=3\cdot\frac{24\cdot25}{2}=900$."],
    ans=r"16.1: $45$ úseček; 16.2: o $33$ puntíků; 16.3: $900$ úseček",
    svg=fig(10, (150, 128, 505, 252)), fn=FN,
    alt="Posloupnost trojúhelníkových obrazců skládaných z šedých trojúhelníků do pater (1., 2. a 3. obrazec) s puntíky ve vrcholech.", cap="",
    codes=["zs2", "r9", "posloupnosti", "algebra", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9D-2023")
