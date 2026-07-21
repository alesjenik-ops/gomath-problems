# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9B 2021 (2. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9B_2021_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2021, 2. řádný termín (M9B)"
CCODE = "M9PBD21C0T02"
YR = 2021
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2021 M9B · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte:",
         r"$\sqrt{\dfrac{16}{0{,}1}+9}=$"],
    solp=[r"$\frac{16}{0{,}1}=160$, tedy $\sqrt{160+9}=\sqrt{169}=13$."],
    ans=r"$13$",
    codes=["zs2", "r9", "aritmetika", "cisla", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 2", pts=2, mins=4, diff="3",
    zad=[r"2.1 \quad Vypočtěte, kolikrát více je polovina z $240$ minut než dvě třetiny z $1$ hodiny.",
         r"2.2 \quad Čtyřúhelník lze rozdělit na dva rovnoramenné trojúhelníky o obsazích $S_1=1\,200\ \mathrm{cm}^2$ a $S_2=0{,}2\ \mathrm{m}^2$, nebo na dva shodné trojúhelníky, každý o obsahu $S_3$. Vypočtěte v dm$^2$ obsah $S_3$."],
    solp=[r"2.1: polovina z $240$ min $=120$ min; dvě třetiny z $60$ min $=40$ min; $120:40=3$.",
          r"2.2: obsah čtyřúhelníku $=S_1+S_2=1\,200\ \mathrm{cm}^2+0{,}2\ \mathrm{m}^2=1\,200\ \mathrm{cm}^2+2\,000\ \mathrm{cm}^2=3\,200\ \mathrm{cm}^2$; dva shodné trojúhelníky mají $S_3=\frac{3\,200}{2}=1\,600\ \mathrm{cm}^2=16\ \mathrm{dm}^2$."],
    ans=r"2.1: $3$krát; 2.2: $16\ \mathrm{dm}^2$",
    codes=["zs2", "r9", "aritmetika", "planimetrie", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $\dfrac{2-\frac{4}{7}}{3-\frac{13}{21}}=$",
         r"3.2 \quad $\left(\dfrac{3}{8}-\dfrac{2}{5}\right)\cdot5-\dfrac{3}{4}=$"],
    solp=[r"3.1: čitatel $2-\frac{4}{7}=\frac{10}{7}$; jmenovatel $3-\frac{13}{21}=\frac{63-13}{21}=\frac{50}{21}$; $\frac{10}{7}:\frac{50}{21}=\frac{10}{7}\cdot\frac{21}{50}=\frac{3}{5}$.",
          r"3.2: $\frac{3}{8}-\frac{2}{5}=\frac{15-16}{40}=-\frac{1}{40}$; $-\frac{1}{40}\cdot5=-\frac{1}{8}$; $-\frac{1}{8}-\frac{3}{4}=-\frac{1}{8}-\frac{6}{8}=-\frac{7}{8}$."],
    ans=r"3.1: $\frac{3}{5}$; 3.2: $-\frac{7}{8}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"4.1 \quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2-x)\cdot3x-2x=$",
         r"4.2 \quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $\left(y-\dfrac{1}{2}\right)^2=$",
         r"4.3 \quad Zjednodušte a rozložte podle vzorce (výsledný výraz uveďte ve tvaru součinu): $5^2-(a^2+16)=$"],
    solp=[r"4.1: $(2-x)\cdot3x-2x=6x-3x^2-2x=4x-3x^2$.",
          r"4.2: $\left(y-\frac{1}{2}\right)^2=y^2-2\cdot y\cdot\frac{1}{2}+\frac{1}{4}=y^2-y+\frac{1}{4}$.",
          r"4.3: $5^2-(a^2+16)=25-a^2-16=9-a^2=(3-a)(3+a)$."],
    ans=r"4.1: $4x-3x^2$; 4.2: $y^2-y+\frac{1}{4}$; 4.3: $(3-a)(3+a)$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $2x\cdot(3{,}2-2{,}3)=2x-(3{,}2-2{,}3)$",
         r"5.2 \quad $\dfrac{y+3}{3}+\dfrac{3}{8}\cdot(y+1)=\dfrac{2y-1}{4}+1$"],
    solp=[r"5.1: $3{,}2-2{,}3=0{,}9$, tedy $2x\cdot0{,}9=2x-0{,}9\Rightarrow1{,}8x=2x-0{,}9\Rightarrow-0{,}2x=-0{,}9\Rightarrow x=4{,}5$.",
          r"5.2: vynásobíme $24$: $8(y+3)+9(y+1)=6(2y-1)+24\Rightarrow8y+24+9y+9=12y-6+24\Rightarrow17y+33=12y+18\Rightarrow5y=-15\Rightarrow y=-3$."],
    ans=r"5.1: $x=4{,}5$; 5.2: $y=-3$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 6", pts=3, mins=6, diff="4",
    zad=[r"Přímá trasa z místa A do místa B měří $4\ \mathrm{km}$. Přesně v polovině této trasy je místo S. Z místa A vystartovali současně 3 kamarádi a za stejný čas zdolali na této trase úseky různých délek: Soňa došla pěšky pouze do místa S (trasa A→S), Barbora doběhla až do místa B (trasa A→S→B) a Karel na kole dojel nejprve do místa B, pak se vrátil zpět do A a nakonec zamířil do místa S (trasa A→S→B→S→A→S). Každý z kamarádů se pohyboval stálou rychlostí.",
         r"6.1 \quad Vypočtěte, kolikrát větší byla rychlost Karla než rychlost Barbory.",
         r"6.2 \quad Vypočtěte, kolik km od místa A byl vzdálen Karel v okamžiku, kdy Barbora míjela místo S.",
         r"6.3 \quad Vypočtěte, kolik m od sebe byli vzdáleni Karel s Barborou v okamžiku, kdy Soňa urazila prvních $400\ \mathrm{m}$."],
    solp=[r"Za stejný čas urazí Soňa $2\ \mathrm{km}$, Barbora $4\ \mathrm{km}$ a Karel $2+2+2+2+2=10\ \mathrm{km}$; rychlosti jsou v poměru drah.",
          r"6.1: $\frac{v_K}{v_B}=\frac{10}{4}=2{,}5$krát.",
          r"6.2: Barbora míjí S po uražení $2\ \mathrm{km}$, tj. v polovině celkového času; Karel za tu dobu urazí $5\ \mathrm{km}$ své trasy, což je $1\ \mathrm{km}$ za bodem B na cestě zpět, tedy je $4-1=3\ \mathrm{km}$ od A.",
          r"6.3: Soňa urazí $400\ \mathrm{m}$ za pětinu svého času; za tu dobu Barbora urazí $0{,}8\ \mathrm{km}$ (je $0{,}8\ \mathrm{km}$ od A) a Karel $2\ \mathrm{km}$ (je právě v S, tj. $2\ \mathrm{km}$ od A); jejich vzdálenost $=2-0{,}8=1{,}2\ \mathrm{km}=1\,200\ \mathrm{m}$."],
    ans=r"6.1: $2{,}5$krát; 6.2: $3\ \mathrm{km}$; 6.3: $1\,200\ \mathrm{m}$",
    codes=["zs2", "r9", "pomer", "slovni", "uvazovani", "bezny-zivot", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 7", pts=3, mins=6, diff="4",
    zad=[r"Každý účastník soutěže mohl získat $0$, $1$, $2$, $3$, nebo $4$ body. Výsledky jsou v tabulce (některá pole nejsou vyplněna). Dívky získaly: $0$ bodů — $7$ dívek, $1$ bod — nevyplněno, $2$ body — $4$ dívky, $3$ body — $0$ dívek, $4$ body — $5$ dívek. Chlapci získali: $2$ body — $5$ chlapců, $3$ body — $4$ chlapci, $4$ body — $2$ chlapci; celkový počet bodů chlapců je $36$ (počty chlapců s $0$ a s $1$ bodem nejsou vyplněny).",
         r"7.1 \quad Dívek, které získaly pouze $1$ bod, bylo dvakrát více než dívek bez bodu. Vypočtěte průměrný bodový zisk dívek.",
         r"7.2 \quad Chlapců, kteří získali pouze $1$ bod, bylo dvakrát více než chlapců bez bodu. Všichni chlapci dohromady získali $36$ bodů. Vypočtěte průměrný bodový zisk chlapců."],
    solp=[r"7.1: dívek bez bodu je $7$, tedy s $1$ bodem $2\cdot7=14$; celkem dívek $7+14+4+0+5=30$; celkem bodů $7\cdot0+14\cdot1+4\cdot2+0\cdot3+5\cdot4=42$; průměr $\frac{42}{30}=1{,}4$ bodu.",
          r"7.2: nechť chlapců bez bodu je $c$, s $1$ bodem $2c$; body celkem $0\cdot c+1\cdot2c+2\cdot5+3\cdot4+4\cdot2=2c+30=36\Rightarrow c=3$; celkem chlapců $3+6+5+4+2=20$; průměr $\frac{36}{20}=1{,}8$ bodu."],
    ans=r"7.1: $1{,}4$ bodu; 7.2: $1{,}8$ bodu",
    codes=["zs2", "r9", "aritmetika", "slovni", "uvazovani", "bezny-zivot", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 8", pts=3, mins=6, diff="4",
    zad=[r"Trojúhelníky $AB_1C_1$ a $AB_2C_2$ jsou pravoúhlé (pravý úhel při vrcholech $B_1$, $B_2$). Společný vrchol A dělí úsečky $B_1B_2$ a $C_1C_2$ ve stejném poměru: $|AB_1|:|AB_2|=|AC_1|:|AC_2|=1:3$. Úsečka $C_1C_2$ měří $20\ \mathrm{cm}$. Odvěsna $B_1C_1$ měří $4\ \mathrm{cm}$.",
         r"8.1 \quad Vypočtěte v cm délku přepony $AC_1$ menšího trojúhelníku.",
         r"8.2 \quad Vypočtěte v cm obvod menšího trojúhelníku ($AB_1C_1$).",
         r"8.3 \quad Vypočtěte v cm$^2$ obsah většího trojúhelníku ($AB_2C_2$)."],
    solp=[r"8.1: bod A dělí úsečku $C_1C_2$ v poměru $1:3$, tedy $AC_1=\frac{1}{4}\cdot20=5\ \mathrm{cm}$.",
          r"8.2: v pravoúhlém trojúhelníku $AB_1C_1$ je přepona $AC_1=5$, odvěsna $B_1C_1=4$, druhá odvěsna $AB_1=\sqrt{5^2-4^2}=3\ \mathrm{cm}$; obvod $=5+4+3=12\ \mathrm{cm}$.",
          r"8.3: trojúhelníky jsou podobné s poměrem $1:3$; obsah menšího $=\frac{1}{2}\cdot3\cdot4=6\ \mathrm{cm}^2$, obsah většího $=6\cdot3^2=54\ \mathrm{cm}^2$."],
    ans=r"8.1: $5\ \mathrm{cm}$; 8.2: $12\ \mathrm{cm}$; 8.3: $54\ \mathrm{cm}^2$",
    svg=fig(4, (398, 532, 525, 676)), fn=FN,
    alt="Dva pravoúhlé trojúhelníky AB1C1 a AB2C2 se společným vrcholem A; menší má odvěsnu B1C1 = 4 cm, úsečka C1C2 = 20 cm, poměr stran 1:3.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "pomer", "vypocet", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 9", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží přímka $c$ a polopřímka AX (viz obrázek). Bod A je vrchol rovnoramenného pravoúhlého trojúhelníku ABC. Vrchol B leží na polopřímce AX, vrchol C leží na přímce $c$. Pravý úhel je buď při vrcholu A, nebo při vrcholu B.",
         r"9.1 \quad Sestrojte trojúhelník ABC s pravým úhlem při vrcholu A.",
         r"9.2 \quad Sestrojte trojúhelník ABC s pravým úhlem při vrcholu B. Vrcholy B, C označte písmeny."],
    solp=[r"Jde o konstrukční úlohu; rovnoramenný pravoúhlý trojúhelník má obě odvěsny stejně dlouhé.",
          r"9.1 (pravý úhel při A): vrchol C je průsečík přímky $c$ s kolmicí k AX vedenou bodem A; protože $|AB|=|AC|$, naneseme délku $|AC|$ na polopřímku AX a získáme vrchol B.",
          r"9.2 (pravý úhel při B): platí $BC\perp AX$ a $|AB|=|BC|$; vrchol C leží na přímce $c$, vrchol B na polopřímce AX. Konstrukci lze provést pomocí úhlu $45^\circ$ při vrcholu A (přepona AC). Hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce dvou rovnoramenných pravoúhlých trojúhelníků $ABC$ (pravý úhel při A, resp. při B); $B$ na polopřímce AX, $C$ na přímce $c$.",
    svg=fig(5, (95, 122, 510, 352)), fn=FN,
    alt="V rovině leží přímka c (stoupající zleva doprava) a vodorovná polopřímka AX s krajním bodem A a bodem X.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 10", pts=3, mins=7, diff="4",
    zad=[r"V rovině leží tři různé body A, M, N (viz obrázek). Bod A je vrchol rovnoběžníku ABCD. Bod M leží uvnitř strany AB tohoto rovnoběžníku, bod N uvnitř strany AD a výška na stranu AB měří $5\ \mathrm{cm}$. Vrchol D má od vrcholů A i B stejnou vzdálenost, tedy $|BD|=|AD|$.",
         r"Sestrojte vrcholy B, C, D rovnoběžníku ABCD, označte je písmeny a rovnoběžník narýsujte."],
    solp=[r"Přímka AB prochází body A a M, přímka AD prochází body A a N.",
          r"Vrchol D leží na polopřímce AN, má od přímky AB vzdálenost $5\ \mathrm{cm}$ (výška) a zároveň leží na ose úsečky AB (podmínka $|AD|=|BD|$) — tím je určen. Vrchol B leží na polopřímce AM tak, aby osa AB procházela bodem D. Vrchol C doplníme jako $C=B+(D-A)$ (strany AD a BC jsou rovnoběžné a shodné). Hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce rovnoběžníku $ABCD$ (B na polopřímce AM, D na polopřímce AN, výška na AB $=5\ \mathrm{cm}$, $|BD|=|AD|$).",
    svg=fig(6, (80, 150, 470, 345)), fn=FN,
    alt="Tři různé body v rovině: A vlevo dole, M vpravo uprostřed a N nahoře uprostřed.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 11", pts=4, mins=6, diff="3",
    zad=[r"V knihovně je $480$ knih psaných česky, zbývajících $40\ \%$ knih je cizojazyčných. Z cizojazyčných knih je jedna osmina psána německy a ostatní anglicky.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 \quad V knihovně je méně než $300$ cizojazyčných knih.",
         r"11.2 \quad V knihovně tvoří německy psané knihy $5\ \%$ všech knih.",
         r"11.3 \quad V knihovně je $280$ knih psaných anglicky."],
    solp=[r"Česky psané knihy tvoří $100\ \%-40\ \%=60\ \%$ všech, tedy všech knih je $\frac{480}{0{,}6}=800$. Cizojazyčných je $40\ \%\cdot800=320$; německy $\frac{1}{8}\cdot320=40$; anglicky $320-40=280$.",
          r"11.1: cizojazyčných je $320$, což není méně než $300$ — \textbf{N}.",
          r"11.2: německy psaných je $40$ z $800$, tj. $\frac{40}{800}=5\ \%$ — \textbf{A}.",
          r"11.3: anglicky psaných je $280$ — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "procenta", "aritmetika", "uvazovani", "slovni", "bezny-zivot", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"V rovině leží rovnoramenný lichoběžník ABCD se základnou AB, rovnostranný trojúhelník BEC a polopřímky AB, CD (viz obrázek). Vnitřní úhel lichoběžníku při základně AB má velikost $65^\circ$ (v obrázku vyznačen u vrcholu D mezi polopřímkou CD a ramenem AD, s nímž je shodný, neboť AB $\parallel$ CD).",
         r"Jaká je velikost úhlu $\varphi$ (úhel při vrcholu B mezi polopřímkou AB za bodem B a ramenem BE rovnostranného trojúhelníku)? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Rovnoramenný lichoběžník má při základně AB úhly $|\angle DAB|=|\angle ABC|=65^\circ$.",
          r"Polopřímka AB pokračuje za bodem B; úhel mezi ní a ramenem BC je $180^\circ-65^\circ=115^\circ$.",
          r"Rovnostranný trojúhelník BEC má $|\angle EBC|=60^\circ$ a vrchol E leží vně lichoběžníku, proto $\varphi=115^\circ-60^\circ=55^\circ$."],
    ans=r"D) $55^\circ$",
    opts=[r"A) menší než $45^\circ$", r"B) $45^\circ$", r"C) $50^\circ$", r"D) $55^\circ$", r"E) větší než $55^\circ$"],
    svg=fig(7, (93, 100, 478, 205)), fn=FN,
    alt="Rovnoramenný lichoběžník ABCD se základnou AB, s úhlem 65° u vrcholu D, a rovnostranný trojúhelník BEC vpravo; hledaný úhel φ je při vrcholu B mezi polopřímkou AB a ramenem BE.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 13", pts=2, mins=3, diff="3",
    zad=[r"Válcovací stroj se pohyboval v přímém směru vpřed. Jeho přední rotační válec vykonal při tomto pohybu $200$ otáček (bez prokluzu). Přední rotační válec má průměr podstavy $0{,}5\ \mathrm{m}$ a zanechává za sebou uválcovaný pás široký $0{,}8\ \mathrm{m}$. (Jedna otáčka je otočení kolem osy válce o $360^\circ$.)",
         r"Kolik m$^2$ uválcoval přední rotační válec? Výsledek je zaokrouhlen na celé m$^2$. Za $\pi$ lze dosadit $3{,}14$."],
    solp=[r"Za jednu otáčku válec ujede vzdálenost rovnou obvodu podstavy $\pi d=3{,}14\cdot0{,}5=1{,}57\ \mathrm{m}$; za $200$ otáček $200\cdot1{,}57=314\ \mathrm{m}$.",
          r"Uválcovaná plocha $=314\ \mathrm{m}\cdot0{,}8\ \mathrm{m}=251{,}2\ \mathrm{m}^2\doteq251\ \mathrm{m}^2$."],
    ans=r"B) $251\ \mathrm{m}^2$",
    opts=[r"A) méně než $250\ \mathrm{m}^2$", r"B) $251\ \mathrm{m}^2$", r"C) $314\ \mathrm{m}^2$", r"D) $331\ \mathrm{m}^2$", r"E) více než $332\ \mathrm{m}^2$"],
    codes=["zs2", "r9", "planimetrie", "obvod", "vypocet", "vyber", "bezny-zivot", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 14", pts=2, mins=3, diff="3",
    zad=[r"Ve třídě 9. A je počet dívek o $4$ větší než počet chlapců. Na exkurzi se z 9. A přihlásila čtvrtina dívek a polovina chlapců. Mezi žáky 9. A, kteří se přihlásili na exkurzi, bylo dívek o $2$ méně než chlapců.",
         r"Neznámou $d$ je označen počet dívek 9. A. Ze které rovnice lze v souladu se zadáním určit počet dívek třídy 9. A?"],
    solp=[r"Počet chlapců je $d-4$. Na exkurzi jde $\frac{d}{4}$ dívek a $\frac{d-4}{2}$ chlapců; dívek je o $2$ méně než chlapců: $\frac{d}{4}=\frac{d-4}{2}-2$, tj. $\frac{d}{4}+2=\frac{d-4}{2}$.",
          r"(Řešením je $d=16$: dívek $16$, chlapců $12$; na exkurzi $4$ dívky a $6$ chlapců.)"],
    ans=r"D) $\dfrac{d}{4}+2=\dfrac{d-4}{2}$",
    opts=[r"A) $\dfrac{d}{2}-2=\dfrac{d+4}{4}$", r"B) $\dfrac{d}{2}+2=\dfrac{d-4}{4}$", r"C) $\dfrac{d}{4}-2=\dfrac{d+4}{2}$", r"D) $\dfrac{d}{4}+2=\dfrac{d-4}{2}$", r"E) $\dfrac{d}{4}+2=\dfrac{d+4}{2}$"],
    codes=["zs2", "r9", "rovnice", "algebra", "slovni", "vyber", "uvazovani", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Mezi třemi sloupy A, B, C jsou uchycena lana. Délka lana uchyceného mezi dvěma sloupy je vždy o $20\ \%$ větší než vzdálenost těchto sloupů. Vzdálenost sloupů A, B je $20\ \mathrm{m}$. Délka lana mezi sloupy A, C je $36\ \mathrm{m}$. Vzdálenost sloupů B, C je o $20\ \%$ menší než vzdálenost sloupů A, B.",
         r"Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).",
         r"15.1 \quad Jaká je délka lana mezi sloupy A, B?",
         r"15.2 \quad Jaká je vzdálenost sloupů A, C?",
         r"15.3 \quad Jaká je délka lana mezi sloupy B, C?",
         r"Nabídka: A) $19{,}2\ \mathrm{m}$; B) $20\ \mathrm{m}$; C) $24\ \mathrm{m}$; D) $28{,}8\ \mathrm{m}$; E) $30\ \mathrm{m}$; F) jiná."],
    solp=[r"15.1: lano AB $=1{,}2\cdot20=24\ \mathrm{m}$ — \textbf{C}.",
          r"15.2: vzdálenost AC $=\frac{36}{1{,}2}=30\ \mathrm{m}$ — \textbf{E}.",
          r"15.3: vzdálenost BC $=0{,}8\cdot20=16\ \mathrm{m}$, lano BC $=1{,}2\cdot16=19{,}2\ \mathrm{m}$ — \textbf{A}."],
    ans=r"15.1: C; 15.2: E; 15.3: A",
    codes=["zs2", "r9", "procenta", "aritmetika", "prirazovani", "slovni", "bezny-zivot", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2021 M9B · úloha 16", pts=4, mins=7, diff="4",
    zad=[r"První čtverec má obvod $60\ \mathrm{cm}$. Každý další čtverec je sestaven z několika shodných obdélníků, přičemž každý z těchto obdélníků má obvod $60\ \mathrm{cm}$. Druhý čtverec je sestaven ze dvou shodných obdélníků, třetí ze tří shodných (užších) obdélníků, čtvrtý ze čtyř shodných (ještě užších) obdélníků atd. (viz obrázek; strana druhého čtverce měří $20\ \mathrm{cm}$).",
         r"16.1 \quad Vypočtěte v cm délku strany třetího čtverce.",
         r"16.2 \quad Vypočtěte v cm obvod devátého čtverce.",
         r"16.3 \quad Určete, kolikátý čtverec má stranu délky $28\ \mathrm{cm}$."],
    solp=[r"$n$-tý čtverec je složen z $n$ svislých obdélníků o šířce $\frac{s_n}{n}$ a výšce $s_n$; každý má obvod $2\left(\frac{s_n}{n}+s_n\right)=60$, tedy $s_n\cdot\frac{n+1}{n}=30$ a $s_n=\frac{30n}{n+1}$.",
          r"16.1: $s_3=\frac{30\cdot3}{4}=22{,}5\ \mathrm{cm}$.",
          r"16.2: $s_9=\frac{30\cdot9}{10}=27\ \mathrm{cm}$, obvod $=4\cdot27=108\ \mathrm{cm}$.",
          r"16.3: $\frac{30n}{n+1}=28\Rightarrow30n=28n+28\Rightarrow n=14$ — čtrnáctý čtverec."],
    ans=r"16.1: $22{,}5\ \mathrm{cm}$; 16.2: $108\ \mathrm{cm}$; 16.3: $14.$ čtverec",
    svg=fig(9, (80, 155, 470, 292)), fn=FN,
    alt="Posloupnost čtverců: 1. čtverec (jeden čtverec), 2. čtverec (dva svislé obdélníky, šířka 20 cm), 3. čtverec (tři svislé obdélníky) a tři tečky naznačující pokračování.", cap="",
    codes=["zs2", "r9", "posloupnosti", "geometrie", "obvod", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9B-2021")
for path, size, names in written:
    print(path, size, "B", len(names), "úloh")
