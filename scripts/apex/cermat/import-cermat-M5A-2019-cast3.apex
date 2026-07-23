String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M5A 2019 – úloha 7.2 (konstrukce)',
  new List<String>{'Uvnitř kružnice $k$ se středem $S$ leží body $A$, $L$. Kružnici $k$ protíná přímka $c$ (viz obrázek).','Body $A$, $L$ jsou vrcholy rovnoramenného trojúhelníku $AKL$. Vrchol $K$ leží na kružnici $k$ a strany $AL$, $KL$ jsou stejně dlouhé.','Sestrojte a označte písmenem chybějící vrchol $K$ trojúhelníku $AKL$ a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 400" font-family="sans-serif"><circle cx="235" cy="215" r="150" fill="none" stroke="#000" stroke-width="2"/><line x1="45" y1="150" x2="450" y2="95" stroke="#000" stroke-width="2"/><text x="452" y="94" font-size="16" font-style="italic">c</text><text x="392" y="330" font-size="16" font-style="italic">k</text><text x="190" y="180" font-size="16" text-anchor="middle">×</text><text x="176" y="176" font-size="15" font-style="italic">A</text><text x="248" y="210" font-size="16" text-anchor="middle">×</text><text x="236" y="226" font-size="15" font-style="italic">S</text><text x="192" y="275" font-size="16" text-anchor="middle">×</text><text x="178" y="272" font-size="15" font-style="italic">L</text></svg>',
  'kruznice-k.svg',
  'Kružnice k se středem S, uvnitř body A a L, přímka c protínající kružnici v horní části.',
  'Výchozí obrázek k úloze 7 (kružnice k, body A, L, přímka c)',
  new List<String>{'Trojúhelník $AKL$ je rovnoramenný se základnou $AK$ a rameny $AL=KL$. Vrchol $K$ je proto stejně vzdálen od $L$ jako bod $A$, leží tedy na kružnici se středem $L$ a poloměrem $|AL|$; zároveň leží na kružnici $k$. Průsečíky obou kružnic dávají dvě řešení $K_1$, $K_2$.'},
  'Dvě řešení: vrchol $K$ je průsečík kružnice $k$ s kružnicí se středem $L$ a poloměrem $|AL|$ (polohy $K_1$, $K_2$) – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2019 – úloha 8',
  new List<String>{'Tři obrazce byly složeny z $5$ shodných čtverců a $4$ shodných rovnoramenných trojúhelníků. Sousední čtverce a trojúhelníky mají vždy společné vrcholy a nikde nepřečnívají (viz obrázek).','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Obvod jednoho čtverce je polovinou obvodu 1. obrazce.','8.2 Obvod 2. obrazce je stejný jako obvod 1. obrazce.','8.3 Obvod 3. obrazce je dvakrát větší než obvod 2. obrazce.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 200" font-family="sans-serif"><text x="95" y="55" font-size="13" text-anchor="middle">1. obrazec</text><rect x="45" y="105" width="55" height="55" fill="none" stroke="#000" stroke-width="2"/><rect x="100" y="105" width="55" height="55" fill="none" stroke="#000" stroke-width="2"/><text x="305" y="55" font-size="13" text-anchor="middle">2. obrazec</text><polygon points="245,160 360,160 390,105 275,105" fill="none" stroke="#000" stroke-width="2"/><line x1="245" y1="160" x2="390" y2="105" stroke="#000" stroke-width="1.4"/><text x="500" y="55" font-size="13" text-anchor="middle">3. obrazec</text><rect x="440" y="120" width="40" height="40" fill="none" stroke="#000" stroke-width="2"/><rect x="480" y="120" width="40" height="40" fill="none" stroke="#000" stroke-width="2"/><rect x="520" y="120" width="40" height="40" fill="none" stroke="#000" stroke-width="2"/><polygon points="440,120 480,120 460,62" fill="none" stroke="#000" stroke-width="2"/><polygon points="460,62 480,120 560,120" fill="none" stroke="#000" stroke-width="2"/></svg>',
  'obrazce.svg',
  'Tři obrazce: dva čtverce vedle sebe; rovnoběžník s úhlopříčkou; dům ze tří čtverců a dvou trojúhelníků.',
  'Tři obrazce ze čtverců a trojúhelníků (schematický nákres)',
  new List<String>{'Označme stranu čtverce $a$; rovnoramenný trojúhelník má základnu $a$ a ramena délky $2a$.','8.1 Obvod čtverce je $4a$, obvod 1. obrazce (dva čtverce vedle sebe) je $6a$. Protože $4a\\neq\\tfrac{1}{2}\\cdot 6a=3a$, tvrzení neplatí – Ne.','8.2 Obvod 2. obrazce (rovnoběžník ze dvou trojúhelníků, strany $a$ a $2a$) je $2\\cdot(a+2a)=6a$, tedy stejný jako obvod 1. obrazce – Ano.','8.3 Obvod 3. obrazce je $12a$, což je dvakrát obvod 2. obrazce ($6a$) – Ano.'},
  '8.1: Ne; 8.2: Ano; 8.3: Ano',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
