String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD21C0T02';
Integer YEAR = 2021;

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
  'CERMAT M9B 2021 – úloha 8',
  new List<String>{'Trojúhelníky $AB_1C_1$ a $AB_2C_2$ jsou pravoúhlé. Společný vrchol $A$ dělí úsečky $B_1B_2$ a $C_1C_2$ ve stejném poměru $|AB_1|:|AB_2|=|AC_1|:|AC_2|=1:3$. Úsečka $C_1C_2$ měří $20$ cm, odvěsna $B_1C_1$ měří $4$ cm (viz obrázek).','Vypočtěte','8.1 v cm délku přepony $AC_1$ menšího trojúhelníku,','8.2 v cm obvod menšího trojúhelníku $AB_1C_1$,','8.3 v cm² obsah většího trojúhelníku $AB_2C_2$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 350" font-family="sans-serif"> <polygon points="340,250 300,250 300,310" fill="none" stroke="#000" stroke-width="2"/> <polygon points="340,250 460,250 460,70" fill="none" stroke="#000" stroke-width="2"/> <polyline points="300,262 312,262 312,250" fill="none" stroke="#000" stroke-width="1"/> <polyline points="460,238 448,238 448,250" fill="none" stroke="#000" stroke-width="1"/> <circle cx="340" cy="250" r="2.5" fill="#000"/> <text x="345" y="245" font-size="15" font-style="italic">A</text> <text x="278" y="244" font-size="15" font-style="italic">B₁</text> <text x="466" y="246" font-size="15" font-style="italic">B₂</text> <text x="280" y="326" font-size="15" font-style="italic">C₁</text> <text x="466" y="66" font-size="15" font-style="italic">C₂</text> <text x="258" y="286" font-size="13">4 cm</text> <text x="398" y="168" font-size="13">20 cm</text> </svg>',
  'trojuhelniky-A.svg',
  'Dva pravoúhlé trojúhelníky se společným vrcholem A, menší AB1C1 a větší AB2C2, poměr 1:3.',
  'Pravoúhlé trojúhelníky se společným vrcholem A',
  new List<String>{'Bod $A$ dělí $C_1C_2$ v poměru $1:3$, takže $AC_1=\\frac{1}{4}\\cdot 20=5$ cm a $AC_2=15$ cm.','8.1 Přepona $AC_1=5$ cm.','8.2 Odvěsny menšího trojúhelníku: $B_1C_1=4$ cm a $AB_1=\\sqrt{5^2-4^2}=3$ cm. Obvod $3+4+5=12$ cm.','8.3 Větší trojúhelník je zvětšením v poměru $3$: $AB_2=9$ cm, $B_2C_2=12$ cm, obsah $\\frac{1}{2}\\cdot 9\\cdot 12=54$ cm².'},
  '8.1: $5$ cm; 8.2: $12$ cm; 8.3: $54$ cm²',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2021 – úloha 9',
  new List<String>{'V rovině leží přímka $c$ a polopřímka $AX$ (viz obrázek).','Bod $A$ je vrchol rovnoramenného pravoúhlého trojúhelníku $ABC$. Vrchol $B$ leží na polopřímce $AX$, vrchol $C$ na přímce $c$. Pravý úhel je buď při vrcholu $A$, nebo při vrcholu $B$.','Sestrojte trojúhelník $ABC$ s pravým úhlem při vrcholu','9.1 $A$,','9.2 $B$,','a vrcholy $B$, $C$ označte písmeny.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 340" font-family="sans-serif"> <line x1="120" y1="150" x2="600" y2="70" stroke="#000" stroke-width="2"/> <text x="608" y="72" font-size="16" font-style="italic">c</text> <line x1="180" y1="290" x2="600" y2="290" stroke="#000" stroke-width="2"/> <line x1="180" y1="282" x2="180" y2="298" stroke="#000" stroke-width="2"/> <line x1="470" y1="282" x2="470" y2="298" stroke="#000" stroke-width="2"/> <text x="176" y="315" font-size="15" font-style="italic">A</text> <text x="466" y="315" font-size="15" font-style="italic">X</text> </svg>',
  'primka-c-AX.svg',
  'Šikmá přímka c a vodorovná polopřímka AX s vyznačenými body A a X.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 (pravý úhel u $A$): kolmice k polopřímce $AX$ v bodě $A$ protne přímku $c$ ve vrcholu $C_1$; na polopřímku $AX$ naneseme $|AB_1|=|AC_1|$, čímž dostaneme vrchol $B_1$.','9.2 (pravý úhel u $B$): rameno $BC$ je kolmé k $AX$ a $|BC|=|AB|$, proto je úhel při vrcholu $A$ roven $45^\\circ$. Polopřímka z $A$ svírající s $AX$ úhel $45^\\circ$ protne přímku $c$ ve vrcholu $C_2$; pata kolmice z $C_2$ na $AX$ je vrchol $B_2$.'},
  'Dvě řešení: trojúhelník $AB_1C_1$ s pravým úhlem u $A$ ($C_1$ na kolmici k $AX$ v bodě $A$, $|AB_1|=|AC_1|$) a trojúhelník $AB_2C_2$ s pravým úhlem u $B_2$ ($C_2$ na polopřímce z $A$ pod úhlem $45^\\circ$, $B_2$ pata kolmice z $C_2$) – viz obrázek v klíči.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
