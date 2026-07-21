# -*- coding: utf-8 -*-
"""Author + generate Apex for CERMAT M9A 2019 (1. řádný termín)."""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from fig import region_svg
import gen

PDF = "work/pdf/M9A_2019_TS.pdf"
SRC = "CERMAT – Jednotná přijímací zkouška 2019, 1. řádný termín (M9A)"
CCODE = "M9PAD19C0T01"
YR = 2019
FN = "obr.svg"


def fig(pi, rect):
    return region_svg(PDF, pi, rect)


P = []

P.append(dict(
    name="CERMAT 2019 M9A · úloha 1", pts=1, mins=2, diff="2",
    zad=[r"Vypočtěte tři pětiny z dvojnásobku čísla $15$."],
    solp=[r"Dvojnásobek čísla $15$ je $30$; tři pětiny z $30$ jsou $\frac{3}{5}\cdot30=18$."],
    ans=r"$18$",
    codes=["zs2", "r9", "aritmetika", "zlomky", "vypocet", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 2", pts=2, mins=3, diff="2",
    zad=[r"Doplňte do rámečku takové číslo, aby platila rovnost.",
         r"2.1 \quad $11$ hodin $17$ minut $-$ $9$ hodin $45$ minut $=\square$ minut",
         r"2.2 \quad $28\ \mathrm{m}^2-\square\ \mathrm{dm}^2=2\,300\ \mathrm{dm}^2+2\,300\ \mathrm{cm}^2$"],
    solp=[r"2.1: $11$ h $17$ min $-\,9$ h $45$ min $=1$ h $32$ min $=92$ minut.",
          r"2.2: $28\ \mathrm{m}^2=2\,800\ \mathrm{dm}^2$ a $2\,300\ \mathrm{cm}^2=23\ \mathrm{dm}^2$; tedy $2\,800-\square=2\,300+23=2\,323$, odkud $\square=477$."],
    ans=r"2.1: $92$; 2.2: $477$",
    codes=["zs2", "r9", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 3", pts=4, mins=6, diff="3",
    zad=[r"Vypočtěte a výsledek zapište zlomkem v základním tvaru.",
         r"3.1 \quad $(6-4)\cdot\dfrac{11}{8}+\dfrac{9}{14}\cdot\dfrac{7}{6}=$",
         r"3.2 \quad $\dfrac{\frac{2\cdot3}{6}-\frac{4}{2\cdot3}}{\frac{2+3}{6}}=$"],
    solp=[r"3.1: $2\cdot\frac{11}{8}+\frac{9\cdot7}{14\cdot6}=\frac{11}{4}+\frac{63}{84}=\frac{11}{4}+\frac{3}{4}=\frac{14}{4}=\frac{7}{2}$.",
          r"3.2: čitatel $\frac{6}{6}-\frac{4}{6}=1-\frac{2}{3}=\frac{1}{3}$; jmenovatel $\frac{5}{6}$; $\frac{1}{3}:\frac{5}{6}=\frac{1}{3}\cdot\frac{6}{5}=\frac{2}{5}$."],
    ans=r"3.1: $\frac{7}{2}$; 3.2: $\frac{2}{5}$",
    codes=["zs2", "r9", "zlomky", "aritmetika", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 4", pts=4, mins=6, diff="3",
    zad=[r"Zjednodušte (výsledný výraz nesmí obsahovat závorky):",
         r"4.1 \quad $(3a-2)\cdot(-2a)=$",
         r"4.2 \quad $(3x-4)^2=$",
         r"4.3 \quad $(2+n)\cdot(3n-3)+(3n-n)\cdot2-n\cdot(3-5)=$"],
    solp=[r"4.1: $(3a-2)\cdot(-2a)=-6a^2+4a$.",
          r"4.2: $(3x-4)^2=9x^2-24x+16$.",
          r"4.3: $(2+n)(3n-3)=3n^2+3n-6$; $(3n-n)\cdot2=4n$; $-n\cdot(3-5)=2n$; součet $3n^2+3n-6+4n+2n=3n^2+9n-6$."],
    ans=r"4.1: $-6a^2+4a$; 4.2: $9x^2-24x+16$; 4.3: $3n^2+9n-6$",
    codes=["zs2", "r9", "vyrazy", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 5", pts=4, mins=7, diff="3",
    zad=[r"Řešte rovnici:",
         r"5.1 \quad $0{,}6x-\dfrac{1}{2}=1{,}4x+1{,}5$",
         r"5.2 \quad $\dfrac{3-2y}{3}=\dfrac{1-2y}{4}+\dfrac{y+3}{6}$"],
    solp=[r"5.1: $0{,}6x-0{,}5=1{,}4x+1{,}5\Rightarrow-0{,}8x=2\Rightarrow x=-2{,}5$.",
          r"5.2: rovnici vynásobíme $12$: $4(3-2y)=3(1-2y)+2(y+3)\Rightarrow12-8y=3-6y+2y+6\Rightarrow12-8y=9-4y\Rightarrow3=4y\Rightarrow y=0{,}75$."],
    ans=r"5.1: $x=-2{,}5$; 5.2: $y=0{,}75$",
    codes=["zs2", "r9", "rovnice", "algebra", "vypocet", "pocetni", "bez-kalkulacky", "bez-kontextu"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 6", pts=4, mins=6, diff="4",
    zad=[r"Všichni chlapci atletického oddílu se seřadili do zástupu podle velikosti. Před Petrem stála jedna osmina celkového počtu chlapců. Hned za Petrem stál jeho bratr Radek a za Radkem ještě pět šestin celkového počtu chlapců. Neznámý celkový počet chlapců atletického oddílu označte $x$.",
         r"6.1 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli před Petrem.",
         r"6.2 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli za Petrem.",
         r"6.3 Vypočtěte celkový počet chlapců atletického oddílu."],
    solp=[r"6.1: před Petrem stála osmina, tj. $\frac{x}{8}$ chlapců.",
          r"6.2: za Petrem stál Radek ($1$) a pět šestin, tj. $\frac{5x}{6}+1$ chlapců.",
          r"6.3: $x=\frac{x}{8}+1+\left(\frac{5x}{6}+1\right)\Rightarrow x-\frac{x}{8}-\frac{5x}{6}=2\Rightarrow\frac{24x-3x-20x}{24}=2\Rightarrow\frac{x}{24}=2\Rightarrow x=48$."],
    ans=r"6.1: $\frac{x}{8}$; 6.2: $\frac{5x}{6}+1$; 6.3: $48$ chlapců",
    codes=["zs2", "r9", "vyrazy", "rovnice", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 7", pts=4, mins=7, diff="4",
    zad=[r"Na obrázku jsou sestaveny dvě různé dvojice ozubených koleček. V první dvojici do sebe zabírají šedé kolečko s $15$ zuby a bílé kolečko s $24$ zuby. Ve druhé dvojici zabírají bílé kolečko s $24$ zuby a černé kolečko, které má méně zubů než bílé. Černé kolečko se za každých $5$ sekund otočí třikrát.",
         r"7.1 Pro první dvojici koleček určete, kolikrát se musí otočit šedé kolečko, než se poprvé obě kolečka vrátí do výchozí polohy.",
         r"7.2 Určete, kolikrát se černé kolečko otočí za $5$ minut.",
         r"7.3 Ve druhé dvojici koleček se obě kolečka vrátí do výchozí polohy poprvé po dvou otáčkách bílého kolečka. Vypočtěte, kolik zubů má černé kolečko."],
    solp=[r"7.1: nejmenší společný násobek počtu zubů je $\mathrm{nsn}(15,24)=120$; šedé kolečko se otočí $120:15=8$krát.",
          r"7.2: za $5$ s se černé kolečko otočí $3$krát, tedy $\frac{3}{5}$krát za sekundu; za $5$ min $=300$ s to je $300\cdot\frac{3}{5}=180$krát.",
          r"7.3: dvě otáčky bílého kolečka odpovídají $2\cdot24=48$ zubům. Černé kolečko má méně než $24$ zubů, jeho počet zubů dělí $48$ a platí $\mathrm{nsn}(24,z)=48$; vyhovuje $z=16$ zubů."],
    ans=r"7.1: $8$krát; 7.2: $180$krát; 7.3: $16$ zubů",
    codes=["zs2", "r9", "aritmetika", "slovni", "vypocet", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 8", pts=2, mins=4, diff="3",
    zad=[r"Z místa $A$ do místa $B$ šla Iva přímou cestou dlouhou $2\ \mathrm{km}$ (na obrázku čárkovaně). Dan šel z místa $A$ do místa $B$ vycházkovou trasou, která má tvar půlkružnice sestrojené nad úsečkou $AB$ jako průměrem (na obrázku plnou čarou).",
         r"8.1 Vypočtěte, kolikrát delší byla cesta Dana než cesta Ivy. (Výsledek zaokrouhlete na setiny.)",
         r"8.2 Vypočtěte, o kolik kilometrů více ušel Dan než Iva. (Výsledek zaokrouhlete na setiny km.)"],
    solp=[r"Průměr půlkružnice je $|AB|=2\ \mathrm{km}$, poloměr $r=1\ \mathrm{km}$. Délka Danovy trasy (půlkružnice) je $\pi r=\pi\doteq3{,}14\ \mathrm{km}$, Ivina cesta je $2\ \mathrm{km}$.",
          r"8.1: $\frac{\pi}{2}\doteq1{,}57$, Danova cesta byla asi $1{,}57$krát delší.",
          r"8.2: $\pi-2\doteq3{,}14-2=1{,}14\ \mathrm{km}$."],
    ans=r"8.1: $1{,}57$krát; 8.2: o $1{,}14$ km",
    svg=fig(4, (80, 118, 470, 182)), fn=FN,
    alt="Úsečka AB délky 2 km jako Ivina přímá cesta (čárkovaně) a půlkružnice sestrojená nad AB jako průměrem jako Danova trasa (plnou čarou); vpravo legenda Iva a Dan.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "obvod", "vypocet", "slovni", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 9", pts=2, mins=5, diff="4",
    zad=[r"V rovině leží přímka $KL$ (viz obrázek). Body $K$, $L$ jsou vrcholy trojúhelníku $KLM$. Velikost úhlu $LKM$ je $30^\circ$. Vzdálenost bodu $L$ od bodu $K$ je stejná jako vzdálenost bodu $L$ od bodu $M$.",
         r"Sestrojte jeden trojúhelník $KLM$."],
    solp=[r"V bodě $K$ naneseme od polopřímky $KL$ úhel $30^\circ$; vrchol $M$ leží na jeho rameni. Zároveň platí $|LM|=|LK|$, takže $M$ leží na kružnici se středem $L$ a poloměrem $|LK|$. Vrchol $M$ je průsečík tohoto ramene s kružnicí.",
          r"Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce."],
    ans=r"Konstrukce trojúhelníku $KLM$: $|\angle LKM|=30^\circ$ a $|LM|=|LK|$ (vrchol $M$ leží na kružnici se středem $L$ a poloměrem $|LK|$).",
    svg=fig(4, (90, 630, 500, 668)), fn=FN,
    alt="Přímka KL s vyznačenými body K a L.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "uhly", "rysovani"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 10", pts=3, mins=6, diff="4",
    zad=[r"V rovině leží přímka $c$ a mimo ni dva různé body $B$, $D$ (viz obrázek). Body $B$, $D$ jsou vrcholy obdélníku $ABCD$. Vrchol $C$ obdélníku $ABCD$ leží na přímce $c$.",
         r"10.1 Sestrojte a označte písmenem chybějící vrchol $C$ obdélníku $ABCD$.",
         r"10.2 Sestrojte a označte písmenem chybějící vrchol $A$ obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení."],
    solp=[r"V obdélníku $ABCD$ jsou $B$ a $D$ protější vrcholy (úhlopříčka $BD$) a při vrcholu $C$ je pravý úhel $BCD$. Vrchol $C$ proto leží na Thaletově kružnici sestrojené nad průměrem $BD$ a současně na přímce $c$ — je jejich průsečíkem.",
          r"Střed $S$ úhlopříčky $BD$ je i středem úhlopříčky $AC$, takže vrchol $A$ je se $C$ souměrně sdružený podle bodu $S$. Podle počtu průsečíků přímky $c$ s Thaletovou kružnicí má úloha až dvě řešení."],
    ans=r"Vrchol $C$ = průsečík přímky $c$ s Thaletovou kružnicí nad průměrem $BD$; vrchol $A$ souměrný s $C$ podle středu úsečky $BD$. Úloha má až $2$ řešení.",
    svg=fig(5, (120, 135, 465, 375)), fn=FN,
    alt="Přímka c a mimo ni dva různé body B a D.", cap="",
    codes=["zs2", "r9", "konstrukce", "planimetrie", "geometrie", "rysovani", "soumernost"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 11", pts=4, mins=6, diff="4",
    zad=[r"Škola má dvě deváté třídy (9. A a 9. B). V 9. A je třikrát více chlapců než dívek a celkem je v této třídě $24$ žáků. Počet všech žáků 9. B je o třetinu větší než počet všech žáků 9. A. V 9. B je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $3:5$.",
         r"Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).",
         r"11.1 V 9. A je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $1:2$.",
         r"11.2 Celkový počet dívek z obou 9. tříd je stejný jako počet chlapců v 9. A.",
         r"11.3 V 9. B je počet dívek o $8$ menší než počet chlapců."],
    solp=[r"9. A: $24$ žáků, chlapců je $3\times$ více než dívek, tedy dívek $6$ a chlapců $18$.",
          r"9. B: žáků je o třetinu více, tj. $24+8=32$; poměr dívek a chlapců $3:5$ ($8$ dílů) dává dívek $12$ a chlapců $20$.",
          r"11.1: poměr v 9. A je $6:18=1:3$, nikoli $1:2$ — \textbf{N}.",
          r"11.2: dívek celkem $6+12=18$, chlapců v 9. A je $18$ — shodné, \textbf{A}.",
          r"11.3: v 9. B je $20-12=8$ — \textbf{A}."],
    ans=r"11.1: N; 11.2: A; 11.3: A",
    codes=["zs2", "r9", "pomer", "aritmetika", "uvazovani", "slovni", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 12", pts=2, mins=4, diff="4",
    zad=[r"Rovinný obrazec je složen z kosočtverce a trojúhelníku, které mají společnou stranu. Kosočtverec má všechny čtyři strany stejně dlouhé. Vnitřní úhel kosočtverce při jednom (horním) vrcholu má velikost $\alpha+24^\circ$. Pravá strana kosočtverce je prodloužena za dolní vrchol; v trojúhelníku, který tím vznikne, svírá dolní strana kosočtverce s tímto prodloužením úhel $68^\circ$ a při zbývajícím (dolním) vrcholu trojúhelníku je úhel $\alpha$.",
         r"Jaká je velikost úhlu $\alpha$? Velikosti úhlů neměřte, ale vypočtěte."],
    solp=[r"Kosočtverec má protější úhly shodné, takže vnitřní úhel kosočtverce při dolním (společném) vrcholu je rovněž $\alpha+24^\circ$.",
          r"Protože pravá strana kosočtverce je prodloužena, jsou tento vnitřní úhel a vyznačený úhel $68^\circ$ úhly vedlejší: $(\alpha+24^\circ)+68^\circ=180^\circ$, tedy $\alpha+92^\circ=180^\circ$ a $\alpha=88^\circ$."],
    ans=r"A) $88^\circ$",
    opts=[r"A) $88^\circ$", r"B) $90^\circ$", r"C) $92^\circ$", r"D) $94^\circ$", r"E) jiná velikost"],
    codes=["zs2", "r9", "planimetrie", "geometrie", "uhly", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 13", pts=2, mins=4, diff="4",
    zad=[r"Čtverec se stranou délky $17\ \mathrm{cm}$ je rozdělen na šedý šestiúhelník a dva shodné bílé trojúhelníky (viz obrázek). Nejdelší strana bílého trojúhelníku má délku $17\ \mathrm{cm}$. Nejkratší strana šedého šestiúhelníku měří $2\ \mathrm{cm}$.",
         r"Jaký je obsah šedého šestiúhelníku?"],
    solp=[r"Každý bílý trojúhelník je pravoúhlý s přeponou $17\ \mathrm{cm}$; jeho odvěsny jsou $8\ \mathrm{cm}$ a $15\ \mathrm{cm}$, neboť $8^2+15^2=17^2$ a $17-15=2\ \mathrm{cm}$ je nejkratší strana šestiúhelníku.",
          r"Obsah jednoho bílého trojúhelníku je $\frac{8\cdot15}{2}=60\ \mathrm{cm}^2$, obou dohromady $120\ \mathrm{cm}^2$.",
          r"Obsah čtverce je $17^2=289\ \mathrm{cm}^2$, obsah šedého šestiúhelníku je $289-120=169\ \mathrm{cm}^2$."],
    ans=r"C) $169\ \mathrm{cm}^2$",
    opts=[r"A) $127\ \mathrm{cm}^2$", r"B) $144\ \mathrm{cm}^2$", r"C) $169\ \mathrm{cm}^2$", r"D) $177\ \mathrm{cm}^2$", r"E) jiný obsah"],
    svg=fig(7, (372, 86, 536, 214)), fn=FN,
    alt="Čtverec o straně 17 cm rozdělený na šedý šestiúhelník a dva shodné bílé pravoúhlé trojúhelníky; nejdelší strany trojúhelníků měří 17 cm, nejkratší strana šestiúhelníku 2 cm.", cap="",
    codes=["zs2", "r9", "planimetrie", "geometrie", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 14", pts=2, mins=4, diff="4",
    zad=[r"Krychle byla slepena z $27$ malých bílých krychliček o hraně délky $2\ \mathrm{cm}$ (sestavených jako $3\times3\times3$). Z krychle jsme odstranili dvě malé krychličky a vzniklo tak nové těleso: jedna krychlička byla odebrána ze středu jedné stěny (uprostřed stěny) a jedna z hrany krychle (krychlička, která měla před odebráním na povrchu dvě stěny). Všechny dostupné plochy nového tělesa jsme obarvili na šedo (i zespodu).",
         r"Jaký je celkový obsah šedých ploch nového tělesa?"],
    solp=[r"Velká krychle má hranu $6\ \mathrm{cm}$ a povrch $6\cdot6^2=216\ \mathrm{cm}^2$; obsah stěny malé krychličky je $2\cdot2=4\ \mathrm{cm}^2$.",
          r"Odebráním krychličky ze středu stěny (měla $1$ stěnu na povrchu) ubude $1$ stěna a přibude $5$ nových stěn, tj. $+4$ stěny $=+16\ \mathrm{cm}^2$.",
          r"Odebráním krychličky z hrany (měla $2$ stěny na povrchu) ubudou $2$ stěny a přibudou $4$ nové stěny, tj. $+2$ stěny $=+8\ \mathrm{cm}^2$.",
          r"Celkem $216+16+8=240\ \mathrm{cm}^2$."],
    ans=r"C) $240\ \mathrm{cm}^2$",
    opts=[r"A) menší než $236\ \mathrm{cm}^2$", r"B) $236\ \mathrm{cm}^2$", r"C) $240\ \mathrm{cm}^2$", r"D) $244\ \mathrm{cm}^2$", r"E) větší než $244\ \mathrm{cm}^2$"],
    codes=["zs2", "r9", "stereometrie", "geometrie", "povrch", "vypocet", "vyber", "bez-kalkulacky"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 15", pts=6, mins=8, diff="3",
    zad=[r"Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).",
         r"15.1 Cena jedné židle se snížila o $25\ \%$ na $1\,800$ korun. Kolik korun stála jedna židle před snížením ceny?",
         r"15.2 Výrobek po zdražení o $20\ \%$ stojí $2\,700$ korun. Kolik korun stál výrobek před zdražením?",
         r"15.3 Jana na lyžařské brýle přispěla $40\ \%$, chybějících $900$ korun za lyžařské brýle doplatil strýc. Cena za lyžařské brýle tvořila $60\ \%$ celé útraty za nákup lyžařských doplňků. Kolik korun činila celá útrata za nákup lyžařských doplňků?",
         r"Nabídka: A) $2\,160$ korun; B) $2\,250$ korun; C) $2\,340$ korun; D) $2\,400$ korun; E) $2\,500$ korun; F) jiný počet korun."],
    solp=[r"15.1: $1\,800$ je $75\ \%$ původní ceny; $1\,800:0{,}75=2\,400$ — \textbf{D}.",
          r"15.2: $2\,700$ je $120\ \%$ původní ceny; $2\,700:1{,}2=2\,250$ — \textbf{B}.",
          r"15.3: chybějících $900$ korun je $60\ \%$ ceny brýlí, tedy brýle stály $900:0{,}6=1\,500$ korun; brýle tvořily $60\ \%$ celé útraty, celá útrata $1\,500:0{,}6=2\,500$ korun — \textbf{E}."],
    ans=r"15.1: D; 15.2: B; 15.3: E",
    codes=["zs2", "r9", "procenta", "aritmetika", "slovni", "prirazovani", "bez-kalkulacky", "bezny-zivot"]))

P.append(dict(
    name="CERMAT 2019 M9A · úloha 16", pts=4, mins=8, diff="5",
    zad=[r"Na čtvercovou desku s lichým počtem políček rozmísťujeme žetony takto: v prvním kroku položíme na každé políčko po obvodu desky $1$ žeton; v každém dalším kroku vybereme všechna dosud prázdná políčka, která bezprostředně sousedí s obsazenými, a na každé z nich položíme o $1$ žeton více než v předchozím kroku. Největší počet žetonů tak bude na prostředním políčku desky. Počty žetonů tvoří soustředné čtvercové rámečky: na vnějším rámečku je $1$ žeton, na dalším $2$, atd. až po střed.",
         r"Pro desku $3\times3$ jsou počty žetonů po řádcích $1,1,1\,/\,1,2,1\,/\,1,1,1$; pro desku $5\times5$ jsou $1,1,1,1,1\,/\,1,2,2,2,1\,/\,1,2,3,2,1\,/\,1,2,2,2,1\,/\,1,1,1,1,1$.",
         r"16.1 Čtvercová deska má na prostředním políčku $9$ žetonů. Určete, kolik políček je v každé řadě této čtvercové desky.",
         r"16.2 Žetony rozmístíme na čtvercovou desku, která má $9\times9$ políček. Určete počet všech políček, na nichž leží právě $2$ žetony.",
         r"16.3 Žetony rozmístíme na dvě čtvercové desky, z nichž jedna má $9\times9$ políček, druhá $11\times11$ políček. Určete, o kolik více žetonů je na větší desce než na menší desce."],
    solp=[r"16.1: prostřední políčko má tolik žetonů, kolik je soustředných rámečků; při $9$ žetonech je rámečků $9$, deska má $2\cdot9-1=17$ políček v každé řadě.",
          r"16.2: na desce $9\times9$ leží právě $2$ žetony na políčkách druhého rámečku od kraje — to je obvod čtverce $7\times7$: $4\cdot7-4=24$ políček.",
          r"16.3: součet žetonů na desce $9\times9$ je $32\cdot1+24\cdot2+16\cdot3+8\cdot4+1\cdot5=165$; na desce $11\times11$ je $40\cdot1+32\cdot2+24\cdot3+16\cdot4+8\cdot5+1\cdot6=286$; rozdíl je $286-165=121$ žetonů."],
    ans=r"16.1: $17$ políček; 16.2: $24$ políček; 16.3: o $121$ žetonů",
    codes=["zs2", "r9", "posloupnosti", "algebra", "uvazovani", "vypocet", "slovni", "bez-kalkulacky"]))

written = gen.emit(P, SRC, CCODE, YR, "scripts/apex/import-cermat-M9A-2019")
for path, size, names in written:
    print("%s  %d B  (%d úloh)" % (path, size, len(names)))
