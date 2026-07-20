String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený K16 – binární zápis grafických objektů',
  new List<String>{'TEXT 1: Každé celé číslo je možné napsat pomocí nul a jedniček; říkáme tomu binární zápis čísla. Například číslo $38$ má binární zápis $100110$, protože $1\\cdot 32+0\\cdot 16+0\\cdot 8+1\\cdot 4+1\\cdot 2+0\\cdot 1=38$.','TEXT 2 (obrázek): V mřížce $4\\times 4$ je $16$ grafických objektů. Každý sloupec i řádek je označen binárním číslem; hodnota objektu je složena z čísla řádku a čísla sloupce. Např. objekt ve 4. řádku (100) a 4. sloupci (110) má hodnotu $100110$, tedy $38$. Sloupce zleva: $100, 101, 010, 110$; řádky shora: $101, 111, 110, 100$.','TEXT 3: V každém z obrázků 16.1–16.3 jsou grafické objekty uspořádané podle určitého pravidla; jeden objekt chybí a je nahrazen symbolem otazníku. Vyberte z mřížky (obrázek 2) objekt, kterým lze chybějící objekt nahradit tak, aby odpovídal pravidlu, a uveďte jeho hodnotu v binárním i desítkovém zápisu.','16.1 Doplňte chybějící objekt v obrázku 16.1.','16.2 Doplňte chybějící objekt v obrázku 16.2.','16.3 Doplňte chybějící objekt v obrázku 16.3.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 380" font-family="sans-serif"> <line x1="100" y1="60" x2="380" y2="60" stroke="#000" stroke-width="1.5"/> <line x1="100" y1="130" x2="380" y2="130" stroke="#000" stroke-width="1.5"/> <line x1="100" y1="200" x2="380" y2="200" stroke="#000" stroke-width="1.5"/> <line x1="100" y1="270" x2="380" y2="270" stroke="#000" stroke-width="1.5"/> <line x1="100" y1="340" x2="380" y2="340" stroke="#000" stroke-width="1.5"/> <line x1="100" y1="60" x2="100" y2="340" stroke="#000" stroke-width="1.5"/> <line x1="170" y1="60" x2="170" y2="340" stroke="#000" stroke-width="1.5"/> <line x1="240" y1="60" x2="240" y2="340" stroke="#000" stroke-width="1.5"/> <line x1="310" y1="60" x2="310" y2="340" stroke="#000" stroke-width="1.5"/> <line x1="380" y1="60" x2="380" y2="340" stroke="#000" stroke-width="1.5"/> <text x="135" y="48" font-size="15" text-anchor="middle" font-weight="bold">100</text> <text x="205" y="48" font-size="15" text-anchor="middle" font-weight="bold">101</text> <text x="275" y="48" font-size="15" text-anchor="middle" font-weight="bold">010</text> <text x="345" y="48" font-size="15" text-anchor="middle" font-weight="bold">110</text> <text x="75" y="100" font-size="15" text-anchor="middle" font-weight="bold">101</text> <text x="75" y="170" font-size="15" text-anchor="middle" font-weight="bold">111</text> <text x="75" y="240" font-size="15" text-anchor="middle" font-weight="bold">110</text> <text x="75" y="310" font-size="15" text-anchor="middle" font-weight="bold">100</text> <circle cx="135" cy="95" r="16" fill="none" stroke="#333"/><circle cx="205" cy="95" r="16" fill="none" stroke="#333"/><circle cx="275" cy="95" r="16" fill="none" stroke="#333"/><circle cx="345" cy="95" r="16" fill="none" stroke="#333"/> <circle cx="135" cy="165" r="16" fill="none" stroke="#333"/><circle cx="205" cy="165" r="16" fill="none" stroke="#333"/><circle cx="275" cy="165" r="16" fill="none" stroke="#333"/><circle cx="345" cy="165" r="16" fill="none" stroke="#333"/> <circle cx="135" cy="235" r="16" fill="none" stroke="#333"/><circle cx="205" cy="235" r="16" fill="none" stroke="#333"/><circle cx="275" cy="235" r="16" fill="none" stroke="#333"/><circle cx="345" cy="235" r="16" fill="none" stroke="#333"/> <circle cx="135" cy="305" r="16" fill="none" stroke="#333"/><circle cx="205" cy="305" r="16" fill="none" stroke="#333"/><circle cx="275" cy="305" r="16" fill="none" stroke="#333"/><circle cx="345" cy="305" r="16" fill="none" stroke="#333"/> </svg>',
  'mrizka-binarni.svg',
  'Schematická mřížka 4 krát 4 (obrázek 2). Sloupce jsou označeny binárními čísly 100, 101, 010, 110; řádky 101, 111, 110, 100. V každém poli je jeden grafický objekt; hodnota objektu je binární číslo řádku a sloupce (např. 4. řádek 100 a 4. sloupec 110 dává 100110, tj. 38).',
  'Referenční mřížka objektů (schematický nákres)',
  new List<String>{'Hodnota objektu se čte jako binární číslo řádku a sloupce (celkem šest číslic). Chybějící objekt v každém obrázku určíme podle pravidla řady a jeho hodnotu přepíšeme z mřížky.','16.1 Objekt má hodnotu $110101$; $1\\cdot 32+1\\cdot 16+0\\cdot 8+1\\cdot 4+0\\cdot 2+1\\cdot 1=53$.','16.2 Objekt má hodnotu $111010$; $1\\cdot 32+1\\cdot 16+1\\cdot 8+0\\cdot 4+1\\cdot 2+0\\cdot 1=58$.','16.3 Objekt má hodnotu $101010$; $1\\cdot 32+0\\cdot 16+1\\cdot 8+0\\cdot 4+1\\cdot 2+0\\cdot 1=42$.'},
  '16.1: $110101=53$; 16.2: $111010=58$; 16.3: $101010=42$',
  6, 10, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
