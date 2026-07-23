String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M5A 2018 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží přímky $b$, $c$, $d$ a mimo ně bod $R$ (viz obrázek). V průsečíku přímek $b$, $c$ je vrchol $A$ obdélníku $ABCD$. Vrchol $B$ téhož obdélníku leží na přímce $b$, vrchol $C$ na přímce $c$ a vrchol $D$ na přímce $d$.','Sestrojte chybějící vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif"><line x1="50" y1="60" x2="470" y2="60" stroke="#000" stroke-width="2"/><text x="58" y="80" font-size="16" font-style="italic">d</text><line x1="60" y1="205" x2="455" y2="150" stroke="#000" stroke-width="2"/><text x="462" y="150" font-size="16" font-style="italic">c</text><line x1="70" y1="165" x2="425" y2="300" stroke="#000" stroke-width="2"/><text x="432" y="305" font-size="16" font-style="italic">b</text><text x="248" y="262" font-size="18">×</text><text x="250" y="282" font-size="15" font-style="italic">R</text></svg>',
  'primky-bcd-R.svg',
  'Přímky b, c, d a bod R mimo ně; přímky b a c se protínají v bodě A.',
  'schematický nákres',
  new List<String>{'Vrchol $A$ je průsečík přímek $b$ a $c$; strana $AB$ leží na přímce $b$. Bodem $A$ vedeme kolmici k přímce $b$ – její průsečík s přímkou $d$ je vrchol $D$. Bod $C$ je průsečík přímky $c$ s rovnoběžkou s přímkou $b$ vedenou bodem $D$; vrchol $B$ je pata kolmice z bodu $C$ na přímku $b$. Obdélník $ABCD$ – viz obrázek v klíči (KSR).'},
  'Konstrukce obdélníku $ABCD$: $A=b\\cap c$, $B$ na přímce $b$, $C$ na přímce $c$, $D$ na přímce $d$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2018 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží přímky $b$, $c$, $d$ a mimo ně bod $R$ (viz obrázek). V průsečíku přímek $b$, $c$ je bod $A$.','Na přímce $c$ sestrojte bod $S$ tak, aby obrazec $ARS$ byl pravoúhlý trojúhelník. Bod $S$ označte a trojúhelník $ARS$ narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif"><line x1="50" y1="60" x2="470" y2="60" stroke="#000" stroke-width="2"/><text x="58" y="80" font-size="16" font-style="italic">d</text><line x1="60" y1="205" x2="455" y2="150" stroke="#000" stroke-width="2"/><text x="462" y="150" font-size="16" font-style="italic">c</text><line x1="70" y1="165" x2="425" y2="300" stroke="#000" stroke-width="2"/><text x="432" y="305" font-size="16" font-style="italic">b</text><text x="248" y="262" font-size="18">×</text><text x="250" y="282" font-size="15" font-style="italic">R</text></svg>',
  'primky-bcd-R.svg',
  'Přímky b, c, d a bod R mimo ně; přímky b a c se protínají v bodě A.',
  'schematický nákres',
  new List<String>{'Vrchol $A$ je průsečík přímek $b$ a $c$; bod $S$ leží na přímce $c$. Pravý úhel při vrcholu $R$: bodem $R$ vedeme kolmici k přímce $AR$, její průsečík s přímkou $c$ je bod $S_1$. Pravý úhel při vrcholu $S$: nad úsečkou $AR$ jako průměrem sestrojíme Thaletovu kružnici, její druhý průsečík s přímkou $c$ (kromě bodu $A$) je bod $S_2$. Úloha má dvě řešení – viz obrázek v klíči (KSR).'},
  'Dvě řešení – body $S_1$, $S_2$ na přímce $c$ (pravý úhel při $R$: $S_1$ na kolmici k $AR$; pravý úhel při $S$: $S_2$ na Thaletově kružnici nad $AR$) – viz obrázek v klíči.',
  3, 6, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
