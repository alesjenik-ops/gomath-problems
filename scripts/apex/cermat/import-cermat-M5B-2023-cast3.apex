String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD23C0T02';
Integer YEAR = 2023;

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
  'CERMAT M5B 2023 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží body $S$, $Q$ a přímka $p$ (viz obrázek).','Na přímce $p$ leží vrcholy $C$, $D$ obdélníku $ABCD$. Bod $S$ je střed strany $AD$ tohoto obdélníku. Bodem $Q$ prochází úhlopříčka obdélníku $ABCD$ (spojnice jeho protějších vrcholů).','Sestrojte všechny vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 220" font-family="sans-serif"> <line x1="40" y1="120" x2="440" y2="55" stroke="#000" stroke-width="2"/> <text x="446" y="57" font-size="16" font-style="italic">p</text> <text x="150" y="150" font-size="15" font-style="italic">S</text> <text x="162" y="145" font-size="14">×</text> <text x="222" y="182" font-size="15" font-style="italic">Q</text> <text x="214" y="172" font-size="14">×</text> </svg>',
  'body-SQ-primka-p.svg',
  'Body S, Q a přímka p v rovině; přímka p mírně stoupá zleva doprava, body S a Q leží pod ní.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Strana $CD$ leží na přímce $p$, strany $AD$ a $BC$ jsou k $p$ kolmé. Protože $S$ je střed strany $AD$ a bod $D$ leží na $p$, je vrchol $D$ patou kolmice z bodu $S$ na přímku $p$ a vrchol $A$ je obrazem bodu $D$ ve středové souměrnosti se středem $S$ (výška obdélníku je dvojnásobek vzdálenosti bodu $S$ od $p$). Úhlopříčka procházející bodem $Q$ je buď $AC$, nebo $BD$: v prvním případě protne přímka $AQ$ přímku $p$ ve vrcholu $C$, ve druhém protne přímka $DQ$ rovnoběžku s $p$ vedenou bodem $A$ ve vrcholu $B$. Úloha má dvě řešení.'},
  'Dvě řešení: $D$ je pata kolmice z $S$ na $p$, $A$ je souměrné s $D$ podle $S$; zbývající vrchol se určí tak, aby úhlopříčka ($AC$, resp. $BD$) procházela bodem $Q$ (viz náčrt v klíči).',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
