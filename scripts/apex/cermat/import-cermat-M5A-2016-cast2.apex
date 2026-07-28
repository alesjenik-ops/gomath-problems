String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD16C0T01';
Integer YEAR = 2016;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5A 2016 – úloha 7 (konstrukce)',
  new List<String>{'Na přímce $o$ leží bod $C$, mimo ni bod $B$ (viz obrázek).','7.1 Narýsujte přímku $p$, která prochází bodem $B$ a je kolmá k přímce $o$. Průsečík přímek $o$, $p$ označte $S$.','7.2 Přímka $o$ rozděluje rovnoramenný trojúhelník $ABC$ na dvě shodné části. Sestrojte chybějící vrchol $A$ trojúhelníku $ABC$ a trojúhelník narýsujte.','7.3 Trojúhelník $ABC$ leží uvnitř čtverce $BCDE$. Sestrojte dva chybějící vrcholy $D$, $E$ čtverce $BCDE$ a čtverec narýsujte.','7.4 Sestrojte přímku $m$, která prochází bodem $B$ a je rovnoběžná s přímkou $AC$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif"> <rect x="6" y="6" width="508" height="348" fill="none" stroke="#999"/> <line x1="40" y1="320" x2="452" y2="108" stroke="#000" stroke-width="2"/> <text x="462" y="104" font-size="17" font-style="italic">o</text> <text x="140" y="264" font-size="16" text-anchor="middle">x</text> <text x="140" y="292" font-size="17" font-style="italic" text-anchor="middle">C</text> <text x="300" y="156" font-size="16" text-anchor="middle">x</text> <text x="316" y="148" font-size="17" font-style="italic">B</text> </svg>',
  'primka-o-bod-B.svg',
  'Výchozí obrázek: přímka o s vyznačeným bodem C a bod B ležící mimo přímku o.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Kolmici $p$ vedeme bodem $B$ k přímce $o$; její průsečík s $o$ je bod $S$.','7.2 Přímka $o$ je osou souměrnosti rovnoramenného trojúhelníku $ABC$ (vrchol $C$ na ní leží). Vrchol $A$ je proto obrazem bodu $B$ v osové souměrnosti podle $o$: leží na přímce $p$ tak, že $|SA|=|SB|$ a body $A$, $B$ jsou na opačných stranách přímky $o$.','7.3 Nad stranou $BC$ sestrojíme čtverec $BCDE$ na té straně, kde leží bod $A$: v bodech $B$ a $C$ vztyčíme kolmice k $BC$ a naneseme na ně délku $|BC|$; získáme vrcholy $D$ (u $C$) a $E$ (u $B$).','7.4 Bodem $B$ vedeme rovnoběžku $m$ s přímkou $AC$.'},
  'Konstrukce: $p\\perp o$ bodem $B$, průsečík $S$; $A$ je obraz bodu $B$ v osové souměrnosti podle $o$ (leží na $p$, $|SA|=|SB|$); čtverec $BCDE$ nad stranou $BC$ na straně bodu $A$; přímka $m$ bodem $B$ rovnoběžná s $AC$ – viz obrázek v klíči.',
  6, 10, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 8',
  new List<String>{'Obrazec je vytvořen ze 2 rovnostranných a 2 rovnoramenných trojúhelníků.','Obvod šedého trojúhelníku je 18 cm. O délkách vyznačených stran $a$, $b$, $c$ víme, že $b$ je polovinou $c$ a dvojnásobkem $a$.','8.1 Vypočítejte obvod černého trojúhelníku.','8.2 Vypočítejte obvod celého obrazce.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 195" font-family="sans-serif"> <polygon points="25,125 97,125 61,63" fill="#ffffff" stroke="#000" stroke-width="2"/> <polygon points="61,63 97,125 200,24" fill="#111111" stroke="#000" stroke-width="2"/> <polygon points="97,125 236,163 200,24" fill="#b9b9b9" stroke="#000" stroke-width="2"/> <polygon points="200,24 236,163 488,24" fill="#ffffff" stroke="#000" stroke-width="2"/> <text x="55" y="143" font-size="16" font-style="italic">a</text> <text x="150" y="158" font-size="16" font-style="italic">b</text> <text x="352" y="82" font-size="16" font-style="italic">c</text> </svg>',
  'obrazec-trojuhelniky.svg',
  'Obrazec ze čtyř trojúhelníků: malý bílý se stranou a, černý, šedý se stranou b a velký bílý se stranou c.',
  'Schematický nákres obrazce',
  new List<String>{'Šedý trojúhelník je rovnostranný se stranou $b$, tedy $3b=18$ a $b=6$ cm.','Odtud $a=\\frac{b}{2}=3$ cm a $c=2b=12$ cm.','8.1 Černý trojúhelník je rovnoramenný se stranami $b$, $b$, $a$: obvod $=6+6+3=15$ cm.','8.2 Obvod obrazce tvoří dvakrát úsečka délky $a$, dvakrát délky $b$ a dvakrát délky $c$: $2\\cdot 3+2\\cdot 6+2\\cdot 12=42$ cm.'},
  '8.1: $15$ cm; 8.2: $42$ cm',
  3, 5, '4',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 9',
  new List<String>{'Rozhodněte o každém tvrzení (9.1–9.3), zda je pravdivé (A), či nikoli (N).','9.1 Čtvrtina jednoho kg je 250 g.','9.2 400 m je možné rozdělit na 1 000 stejných dílů délky 40 cm.','9.3 Čtyři čtverce o obsahu 25 cm$^2$ mají dohromady obsah 1 m$^2$.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'9.1 $1$ kg $=1\\,000$ g, čtvrtina je $1\\,000:4=250$ g. Tvrzení platí.','9.2 $1\\,000\\cdot 40$ cm $=40\\,000$ cm $=400$ m. Tvrzení platí.','9.3 $4\\cdot 25=100$ cm$^2$, ale $1$ m$^2=10\\,000$ cm$^2$. Tvrzení neplatí.'},
  '9.1: Ano; 9.2: Ano; 9.3: Ne',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
