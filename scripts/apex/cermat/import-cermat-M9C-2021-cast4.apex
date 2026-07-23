String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD21C0T03';
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
  'CERMAT M9C 2021 – úloha 10',
  new List<String>{'V rovině leží body $A$, $B$, $L$ (viz obrázek).','Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Osy vnitřních úhlů $BAC$ a $ABC$ tohoto trojúhelníku procházejí bodem $L$.','Sestrojte vrchol $C$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 400" font-family="sans-serif"> <rect x="8" y="8" width="624" height="384" fill="none" stroke="#ccc"/> <line x1="293" y1="233" x2="307" y2="247" stroke="#000" stroke-width="1.6"/> <line x1="293" y1="247" x2="307" y2="233" stroke="#000" stroke-width="1.6"/> <text x="297" y="266" font-size="16" font-style="italic">L</text> <line x1="553" y1="213" x2="567" y2="227" stroke="#000" stroke-width="1.6"/> <line x1="553" y1="227" x2="567" y2="213" stroke="#000" stroke-width="1.6"/> <text x="572" y="232" font-size="16" font-style="italic">B</text> <line x1="243" y1="333" x2="257" y2="347" stroke="#000" stroke-width="1.6"/> <line x1="243" y1="347" x2="257" y2="333" stroke="#000" stroke-width="1.6"/> <text x="244" y="368" font-size="16" font-style="italic">A</text> </svg>',
  'body-abl.svg',
  'Body A, B a L v rovině (A dole, B vpravo, L uprostřed).',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Přímka $AL$ je osou úhlu $BAC$, přímka $BL$ je osou úhlu $ABC$. Polopřímku $AC$ získáme osovou souměrností polopřímky $AB$ podle přímky $AL$, polopřímku $BC$ osovou souměrností polopřímky $BA$ podle přímky $BL$. Vrchol $C$ je průsečíkem těchto dvou polopřímek. Úloha má jedno řešení.'},
  'Vrchol $C$ je průsečík polopřímek $AC$ a $BC$, které vzniknou osovou souměrností polopřímek $AB$ a $BA$ podle přímek $AL$ a $BL$ (os úhlů) – viz obrázek v klíči.',
  2, 6, '4',
  new List<String>{'zs2','r9','planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 11',
  new List<String>{'Od startu $S$ do cíle $C$ vede jedna snadná cyklistická trasa údolími a druhá náročná přes kopce. Obě trasy se kříží v místě $K$. Po snadné trase ujedeme v první části od startu $S$ do místa $K$ 45 km, což je o polovinu více, než ujedeme v druhé části od místa $K$ do cíle $C$. Náročná trasa je dlouhá 45 km a její první část od startu $S$ do místa $K$ je o pětinu kratší než její druhá část od místa $K$ do cíle $C$.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).','11.1 U snadné trasy je poměr délky první části ku délce druhé části $2:1$.','11.2 Druhá část snadné trasy měří 30 km.','11.3 Druhá část náročné trasy měří 25 km.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 240" font-family="sans-serif"> <path d="M70,150 C90,70 170,70 200,150 C230,70 320,70 360,150" fill="none" stroke="#000" stroke-width="1.7"/> <path d="M70,150 C95,225 170,225 200,150 C245,225 320,225 360,150" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="6 4"/> <text x="82" y="52" font-size="13">Snadná trasa</text> <text x="232" y="232" font-size="13">Náročná trasa</text> <line x1="63" y1="143" x2="77" y2="157" stroke="#000" stroke-width="1.6"/> <line x1="63" y1="157" x2="77" y2="143" stroke="#000" stroke-width="1.6"/> <line x1="193" y1="143" x2="207" y2="157" stroke="#000" stroke-width="1.6"/> <line x1="193" y1="157" x2="207" y2="143" stroke="#000" stroke-width="1.6"/> <line x1="353" y1="143" x2="367" y2="157" stroke="#000" stroke-width="1.6"/> <line x1="353" y1="157" x2="367" y2="143" stroke="#000" stroke-width="1.6"/> <text x="55" y="176" font-size="15" font-style="italic">S</text> <text x="196" y="139" font-size="15" font-style="italic">K</text> <text x="366" y="176" font-size="15" font-style="italic">C</text> </svg>',
  'trasy.svg',
  'Schematická mapka: snadná trasa (plná) a náročná trasa (čárkovaná) mezi body S, K a C.',
  'Schematický nákres obou tras',
  new List<String>{'Snadná trasa: první část 45 km je o polovinu více než druhá část, tedy $45=1{,}5\\cdot d$ a druhá část $d=30$ km; poměr $45:30=3:2$.','11.1 Poměr je $3:2$, nikoli $2:1$ → Ne.','11.2 Druhá část snadné trasy měří $30$ km → Ano.','11.3 Náročná trasa: druhá část $d$, první část $\\dfrac{4}{5}d$; celkem $\\dfrac{4}{5}d+d=\\dfrac{9}{5}d=45$, tedy $d=25$ km → Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  4, 5, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
