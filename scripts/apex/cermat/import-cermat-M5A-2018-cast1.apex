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
  'CERMAT M5A 2018 – úloha 1.1',
  new List<String>{'Vypočtěte: $4\\cdot 16-16:2+0\\cdot 125-25=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací: $64-8+0-25=31$.'},
  '$31$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2018 – úloha 1.2',
  new List<String>{'Vypočtěte: $100-[35-(15+11)]-35=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$100-[35-26]-35=100-9-35=56$.'},
  '$56$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2018 – úloha 2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','2.1  $2$ m $12$ cm $=85$ cm $+\\ \\square\\ $ cm','2.2  $26$ km $-\\ \\square\\ \\cdot 400$ m $=9$ km $200$ m','2.3  $\\square\\ $ minut $+\\,300$ sekund $=1$ hodina'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 $2$ m $12$ cm $=212$ cm; do rámečku patří $212-85=127$.','2.2 $26$ km $=26\\,000$ m a $9$ km $200$ m $=9\\,200$ m; $(26\\,000-9\\,200):400=16\\,800:400=42$.','2.3 $1$ hodina $=3\\,600$ s, $300$ s $=5$ min; do rámečku patří $60-5=55$.'},
  '2.1: $127$; 2.2: $42$; 2.3: $55$',
  3, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2018 – úloha 3',
  new List<String>{'Farmář Malý svou úrodu pšenice plní do malých pytlů. Do každého pytle se vejde $30$ kg pšenice. Farmáři zbývá naplnit do pytlů ještě $150$ kg pšenice, což je jedna čtvrtina jeho úrody pšenice. Farmář Velký má o polovinu větší úrodu pšenice než farmář Malý. Celou svou úrodu pšenice již uskladnil ve velkých pytlích, do každého nasypal $50$ kg pšenice.','3.1 Vypočtěte, kolik malých pytlů pšenice již farmář Malý naplnil.','3.2 Vypočtěte, v kolika velkých pytlích uskladnil celou svou úrodu pšenice farmář Velký.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 190" font-family="sans-serif"><text x="145" y="20" font-size="13" text-anchor="middle" font-weight="bold">Farmář Malý</text><rect x="20" y="30" width="255" height="125" fill="none" stroke="#000"/><ellipse cx="58" cy="112" rx="15" ry="22" fill="#efe6d0" stroke="#000"/><rect x="54" y="84" width="8" height="8" fill="#efe6d0" stroke="#000"/><ellipse cx="96" cy="112" rx="15" ry="22" fill="#efe6d0" stroke="#000"/><rect x="92" y="84" width="8" height="8" fill="#efe6d0" stroke="#000"/><ellipse cx="134" cy="112" rx="15" ry="22" fill="#efe6d0" stroke="#000"/><rect x="130" y="84" width="8" height="8" fill="#efe6d0" stroke="#000"/><text x="170" y="118" font-size="18">…</text><polygon points="205,145 255,145 230,98" fill="#9e9e9e" stroke="#000"/><text x="230" y="170" font-size="11" text-anchor="middle">zbývá 150 kg</text><text x="425" y="20" font-size="13" text-anchor="middle" font-weight="bold">Farmář Velký</text><rect x="305" y="30" width="245" height="125" fill="none" stroke="#000"/><ellipse cx="345" cy="120" rx="24" ry="33" fill="#efe6d0" stroke="#000"/><rect x="341" y="81" width="8" height="8" fill="#efe6d0" stroke="#000"/><ellipse cx="400" cy="120" rx="24" ry="33" fill="#efe6d0" stroke="#000"/><rect x="396" y="81" width="8" height="8" fill="#efe6d0" stroke="#000"/><text x="443" y="126" font-size="18">…</text><ellipse cx="515" cy="120" rx="24" ry="33" fill="#efe6d0" stroke="#000"/><rect x="511" y="81" width="8" height="8" fill="#efe6d0" stroke="#000"/></svg>',
  'farmari-pytle.svg',
  'Schéma: farmář Malý s malými pytli a zbývajícími 150 kg pšenice, farmář Velký s velkými pytli.',
  'schematický nákres',
  new List<String>{'3.1 $150$ kg je čtvrtina úrody, celá úroda farmáře Malého je $4\\cdot 150=600$ kg. Již naplnil $600-150=450$ kg, tj. $450:30=15$ pytlů.','3.2 Farmář Velký má o polovinu větší úrodu: $600+300=900$ kg; po $50$ kg to je $900:50=18$ pytlů.'},
  '3.1: $15$ pytlů; 3.2: $18$ pytlů',
  4, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
