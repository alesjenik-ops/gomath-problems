String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD21C0T02';
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
  'CERMAT M7B 2021 – úloha 12',
  new List<String>{'Celý povrch dřevěného kvádru, jehož síť je na obrázku, jsme obarvili modrou barvou. Obarvený kvádr jsme beze zbytku rozřezali na malé krychličky o hraně délky $1$ cm.','Kolik krychliček vzniklo rozřezáním kvádru?'},
  new List<String>{'A) $10$','B) $20$','C) $28$','D) $48$','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 260" font-family="sans-serif"> <rect x="60" y="110" width="36" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="96" y="110" width="90" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="186" y="110" width="36" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="222" y="110" width="90" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="186" y="20" width="36" height="90" fill="#d9d9d9" stroke="#000"/> <rect x="186" y="146" width="36" height="90" fill="#d9d9d9" stroke="#000"/> <text x="48" y="132" font-size="12" text-anchor="end">2 cm</text> <text x="78" y="104" font-size="12" text-anchor="middle">2 cm</text> <text x="141" y="104" font-size="12" text-anchor="middle">5 cm</text> </svg>',
  'sit-kvadru.svg',
  'Síť kvádru ve tvaru kříže; hrany kvádru jsou 2 cm, 2 cm a 5 cm.',
  'Síť kvádru',
  new List<String>{'Kvádr má rozměry $2\\times 2\\times 5$ cm, objem $2\\cdot 2\\cdot 5=20$ cm³. Vznikne $20$ krychliček o hraně $1$ cm.'},
  'B) $20$',
  2, 3, '2',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2021 – úloha 13',
  new List<String>{'Celý povrch dřevěného kvádru, jehož síť je na obrázku, jsme obarvili modrou barvou. Obarvený kvádr jsme beze zbytku rozřezali na malé krychličky o hraně délky $1$ cm.','Kolik vzniklých krychliček má právě dvě modré stěny?'},
  new List<String>{'A) $6$','B) $8$','C) $12$','D) $20$','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 260" font-family="sans-serif"> <rect x="60" y="110" width="36" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="96" y="110" width="90" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="186" y="110" width="36" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="222" y="110" width="90" height="36" fill="#d9d9d9" stroke="#000"/> <rect x="186" y="20" width="36" height="90" fill="#d9d9d9" stroke="#000"/> <rect x="186" y="146" width="36" height="90" fill="#d9d9d9" stroke="#000"/> <text x="48" y="132" font-size="12" text-anchor="end">2 cm</text> <text x="78" y="104" font-size="12" text-anchor="middle">2 cm</text> <text x="141" y="104" font-size="12" text-anchor="middle">5 cm</text> </svg>',
  'sit-kvadru.svg',
  'Síť kvádru ve tvaru kříže; hrany kvádru jsou 2 cm, 2 cm a 5 cm.',
  'Síť kvádru',
  new List<String>{'Právě dvě obarvené stěny mají krychličky ležící na hranách kvádru (mimo rohy). U kvádru $2\\times 2\\times 5$ jsou to jen krychličky na čtyřech hranách délky $5$: $4\\cdot(5-2)=12$ krychliček.'},
  'C) $12$',
  2, 4, '3',
  new List<String>{'zs2','r7','stereometrie','porozumeni','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
