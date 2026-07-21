String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2026 M9C · úloha 10',
  new List<String>{'V rovině leží body $U$, $V$ a přímka $k$ (viz obrázek).','Bod $U$ leží uvnitř strany $KN$ obdélníku $KLMN$. Na přímce $k$ leží strana $KL$ tohoto obdélníku. Bod $V$ má stejnou vzdálenost od všech čtyř vrcholů obdélníku $KLMN$.','Sestrojte všechny vrcholy obdélníku $KLMN$, označte je písmeny a obdélník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 319"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M467 4L468 4L468 23L467 23Z" style="fill:#000000"/><path d="M4 314L5 314L5 315L4 315Z" style="fill:#000000"/><path d="M4 314L5 314L5 315L4 315Z" style="fill:#000000"/><path d="M5 314L467 314L467 315L5 315Z" style="fill:#000000"/><path d="M467 314L468 314L468 315L467 315Z" style="fill:#000000"/><path d="M467 314L468 314L468 315L467 315Z" style="fill:#000000"/><path d="M4 23L5 23L5 314L4 314Z" style="fill:#000000"/><path d="M467 23L468 23L468 314L467 314Z" style="fill:#000000"/><path d="M60 162L66 167M66 162L60 167M171 161L176 166M176 161L171 166M392 166L38 266" style="fill:none;stroke:#000000;stroke-width:2"/><text x="55" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">U</text><text x="111" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V</text><text x="144" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="171" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text><text x="176" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="68" y="160" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">U</text><text x="176" y="159" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V</text><text x="389" y="182" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text></svg>',
  'obr.svg',
  'Body U, V a přímka k.',
  '',
  new List<String>{'Bod $V$ stejně vzdálený od všech vrcholů je průsečík úhlopříček, tedy střed obdélníku.','Vrcholy $K$, $L$ leží na přímce $k$; vzdálenost $V$ od $k$ je polovina strany $KN$, proto patu kolmice z $V$ na $k$ a bod $U$ využijeme k určení strany $KN$.','Sestrojíme kolmici z $V$ na $k$ (její pata je střed strany $KL$), z bodu $U$ dopočítáme vrcholy $K$, $N$ a osovou souměrností podle $V$ pak $M$, $L$.'},
  'Bod $V$ je střed obdélníku (průsečík úhlopříček); $K$, $L$ leží na $k$, strana $KN$ prochází bodem $U$ (viz konstrukce).',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PCD26C0T03', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
