String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD21C0T03';
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
  'CERMAT M5C 2021 – úloha 13',
  new List<String>{'Na podložce byla ze stejných krychliček postavena velká krychle, která měla $4$ vrstvy po $16$ krychličkách. Klára odebrala z velké krychle několik krychliček, aby vytvořila stavbu podle nákresu 1. Mirek odebral z Klářiny stavby několik krychliček, aby vytvořil stavbu podle nákresu 2. Nora odebrala z Mirkovy stavby několik krychliček, aby vytvořila stavbu podle nákresu 3. (Děti krychličky pouze odebíraly, s ostatními krychličkami nehýbaly.)','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 Kolik krychliček odebrala Klára z velké krychle?','13.2 Kolik nejvíce krychliček mohl Mirek odebrat z Klářiny stavby?','13.3 Kolik nejméně krychliček musela Nora odebrat z Mirkovy stavby?'},
  new List<String>{'A) $7$','B) $6$','C) $5$','D) $4$','E) $3$','F) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif"> <text x="90" y="20" font-size="13" text-anchor="middle">Nákres 1</text> <text x="280" y="20" font-size="13" text-anchor="middle">Nákres 2</text> <text x="470" y="20" font-size="13" text-anchor="middle">Nákres 3</text> <rect x="40" y="40" width="100" height="60" fill="#e6e6e6" stroke="#000"/> <rect x="40" y="80" width="100" height="20" fill="#cccccc" stroke="#000"/> <rect x="230" y="48" width="100" height="52" fill="#e6e6e6" stroke="#000"/> <rect x="230" y="80" width="100" height="20" fill="#cccccc" stroke="#000"/> <rect x="420" y="56" width="100" height="44" fill="#e6e6e6" stroke="#000"/> <rect x="420" y="80" width="100" height="20" fill="#cccccc" stroke="#000"/> <text x="90" y="118" font-size="12" text-anchor="middle">Klára</text> <text x="280" y="118" font-size="12" text-anchor="middle">Mirek</text> <text x="470" y="118" font-size="12" text-anchor="middle">Nora</text> <text x="280" y="142" font-size="11" text-anchor="middle" fill="#666">Prostorové stavby z krychliček (schematicky) – posuzuje se podle originálu.</text> </svg>',
  'krychle-nakresy.svg',
  'Tři nákresy postupně zmenšovaných staveb z krychliček (Klára, Mirek, Nora) – schematicky.',
  'Nákres 1, 2 a 3 (schematicky)',
  new List<String>{'Velká krychle má $4\\cdot 16=64$ krychliček; z porovnání nákresů:','13.1 Klára odebrala $7$ krychliček → A.','13.2 Mirek mohl odebrat nejvíce $5$ krychliček → C.','13.3 Nora musela odebrat nejméně $6$ krychliček → B.'},
  '13.1: A ($7$); 13.2: C ($5$); 13.3: B ($6$)',
  5, 5, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
