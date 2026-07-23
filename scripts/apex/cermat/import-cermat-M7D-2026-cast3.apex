String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M7D 2026 – úloha 7',
  new List<String>{'Čtyřúhelník $BCDE$ je složen z pravoúhlého lichoběžníku $ACDE$ a pravoúhlého trojúhelníku $ABC$. Lichoběžník $ACDE$ a trojúhelník $ABC$ mají stejný obsah. V lichoběžníku $ACDE$ má základna $AC$ délku $6$ cm a základna $DE$ délku $3$ cm. Délka úsečky $BE$ je $15$ cm.','7.1 Vypočtěte, jaký je poměr délky úsečky $AE$ ku délce úsečky $AB$.','7.2 Vypočtěte v cm² obsah čtyřúhelníku $BCDE$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 275" font-family="sans-serif"> <polygon points="415,220 190,70 40,145 40,220" fill="none" stroke="#000" stroke-width="2"/> <line x1="190" y1="70" x2="190" y2="220" stroke="#000" stroke-width="2"/> <polyline points="40,220 52,220 52,208 40,208" fill="none" stroke="#000"/> <polyline points="190,220 202,220 202,208 190,208" fill="none" stroke="#000"/> <text x="184" y="62" font-size="15" font-style="italic">C</text> <text x="26" y="145" font-size="15" font-style="italic">D</text> <text x="26" y="232" font-size="15" font-style="italic">E</text> <text x="186" y="238" font-size="15" font-style="italic">A</text> <text x="418" y="228" font-size="15" font-style="italic">B</text> <text x="200" y="150" font-size="13">6 cm</text> <text x="8" y="188" font-size="13">3 cm</text> <line x1="40" y1="248" x2="415" y2="248" stroke="#444"/> <polygon points="40,248 48,244 48,252" fill="#444"/> <polygon points="415,248 407,244 407,252" fill="#444"/> <text x="212" y="266" font-size="13" text-anchor="middle">15 cm</text> </svg>',
  'ctyruhelnik-BCDE.svg',
  'Čtyřúhelník BCDE složený z pravoúhlého lichoběžníku ACDE a pravoúhlého trojúhelníku ABC; AC = 6 cm, DE = 3 cm, EB = 15 cm.',
  'Schematický nákres čtyřúhelníku BCDE',
  new List<String>{'7.1 Obsah lichoběžníku $S_1=\\frac{3+6}{2}\\cdot|AE|=4{,}5\\cdot|AE|$; obsah trojúhelníku $S_2=\\frac{6}{2}\\cdot|AB|=3\\cdot|AB|$. Z $S_1=S_2$ plyne $|AE|:|AB|=3:4{,}5=2:3$.','7.2 $BE=AE+AB=15$ cm se dělí v poměru $2:3$ (5 dílů), díl $=3$ cm, tedy $|AB|=9$ cm. $S_2=\\frac{6\\cdot 9}{2}=27$ cm² a $S_1=S_2=27$ cm². Obsah $BCDE=S_1+S_2=54$ cm².'},
  '7.1: $2:3$; 7.2: $54$ cm²',
  4, 7, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2026 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží přímka $p$ a body $B$, $D$ (viz obrázek). Body $B$, $D$ jsou vrcholy čtverce $BCDE$. Vrchol $C$ tohoto čtverce má od přímky $p$ větší vzdálenost než bod $B$.','8.1 Sestrojte vrcholy $C$, $E$ čtverce $BCDE$, označte je písmeny a čtverec narýsujte.','8.2 Body $B$, $C$, $D$ jsou zároveň vrcholy lichoběžníku $ABCD$. Vrchol $A$ tohoto lichoběžníku leží na přímce $p$. Sestrojte vrchol $A$ lichoběžníku $ABCD$, označte ho písmenem a lichoběžník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 380" font-family="sans-serif"> <rect x="10" y="10" width="460" height="360" fill="none" stroke="#ccc"/> <line x1="150" y1="40" x2="360" y2="340" stroke="#000" stroke-width="2"/> <text x="138" y="46" font-size="16" font-style="italic">p</text> <text x="416" y="158" font-size="15" font-style="italic">D</text> <text x="412" y="174" font-size="15">×</text> <text x="416" y="286" font-size="15" font-style="italic">B</text> <text x="412" y="302" font-size="15">×</text> </svg>',
  'primka-p-body-BD.svg',
  'Přímka p a body B, D ležící v rovině vpravo od přímky.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'8.1 $B$ a $D$ jsou protější vrcholy (úhlopříčka) čtverce. Střed $S$ je střed úsečky $BD$; vrcholy $C$, $E$ leží na ose úsečky $BD$ ve vzdálenosti $\\frac{1}{2}|BD|$ od $S$. Z obou průsečíků je $C$ ten vzdálenější od přímky $p$, druhý je $E$.','8.2 Vrchol $A$ leží na přímce $p$ a doplňuje $B$, $C$, $D$ na lichoběžník (jedna dvojice stran je rovnoběžná). Vede k dvěma řešením $A_1$, $A_2$ (viz náčrt v klíči).'},
  'Čtverec $BCDE$ nad úhlopříčkou $BD$ ($C$, $E$ na ose úsečky $BD$, $C$ dál od přímky $p$); lichoběžník $ABCD$ s vrcholem $A$ na přímce $p$ má dvě řešení $A_1$, $A_2$ – viz náčrt v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
