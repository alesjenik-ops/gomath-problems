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
  'CERMAT M5C 2021 – úloha 12',
  new List<String>{'Do čtvercové sítě jsme naskládali tmavé čtverce, a vytvořili tak ornament, který není souměrný podle žádné osy. Některé čtverce jsou označeny písmeny (viz obrázek).','Odebráním jednoho ze čtverců A, B, C, D, nebo E vytvoříme nový ornament. Nový ornament buď je, nebo není souměrný podle některé osy (svislé, vodorovné nebo šikmé).','Který z označených čtverců odebereme, aby ani nový ornament nebyl souměrný podle žádné osy?'},
  new List<String>{'A) čtverec A','B) čtverec B','C) čtverec C','D) čtverec D','E) čtverec E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240" font-family="sans-serif"><rect x="108" y="12" width="24" height="24" fill="#808080"/><rect x="60" y="36" width="24" height="24" fill="#808080"/><rect x="108" y="36" width="24" height="24" fill="#808080"/><rect x="156" y="36" width="24" height="24" fill="#808080"/><rect x="36" y="60" width="24" height="24" fill="#808080"/><rect x="84" y="60" width="24" height="24" fill="#808080"/><text x="96.0" y="77.0" font-size="14" fill="#fff" text-anchor="middle">B</text><rect x="132" y="60" width="24" height="24" fill="#808080"/><rect x="180" y="60" width="24" height="24" fill="#808080"/><rect x="84" y="84" width="24" height="24" fill="#808080"/><rect x="132" y="84" width="24" height="24" fill="#808080"/><rect x="156" y="84" width="24" height="24" fill="#808080"/><text x="168.0" y="101.0" font-size="14" fill="#fff" text-anchor="middle">C</text><rect x="12" y="108" width="24" height="24" fill="#808080"/><rect x="36" y="108" width="24" height="24" fill="#808080"/><rect x="108" y="108" width="24" height="24" fill="#808080"/><rect x="180" y="108" width="24" height="24" fill="#808080"/><rect x="204" y="108" width="24" height="24" fill="#808080"/><rect x="60" y="132" width="24" height="24" fill="#808080"/><text x="72.0" y="149.0" font-size="14" fill="#fff" text-anchor="middle">A</text><rect x="84" y="132" width="24" height="24" fill="#808080"/><rect x="132" y="132" width="24" height="24" fill="#808080"/><rect x="156" y="132" width="24" height="24" fill="#808080"/><text x="168.0" y="149.0" font-size="14" fill="#fff" text-anchor="middle">D</text><rect x="36" y="156" width="24" height="24" fill="#808080"/><rect x="84" y="156" width="24" height="24" fill="#808080"/><rect x="132" y="156" width="24" height="24" fill="#808080"/><text x="144.0" y="173.0" font-size="14" fill="#fff" text-anchor="middle">E</text><rect x="180" y="156" width="24" height="24" fill="#808080"/><rect x="60" y="180" width="24" height="24" fill="#808080"/><rect x="108" y="180" width="24" height="24" fill="#808080"/><rect x="156" y="180" width="24" height="24" fill="#808080"/><rect x="108" y="204" width="24" height="24" fill="#808080"/><line x1="12" y1="12" x2="12" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="12" x2="228" y2="12" stroke="#000" stroke-width="1.5"/><line x1="36" y1="12" x2="36" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="36" x2="228" y2="36" stroke="#000" stroke-width="1.5"/><line x1="60" y1="12" x2="60" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="60" x2="228" y2="60" stroke="#000" stroke-width="1.5"/><line x1="84" y1="12" x2="84" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="84" x2="228" y2="84" stroke="#000" stroke-width="1.5"/><line x1="108" y1="12" x2="108" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="108" x2="228" y2="108" stroke="#000" stroke-width="1.5"/><line x1="132" y1="12" x2="132" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="132" x2="228" y2="132" stroke="#000" stroke-width="1.5"/><line x1="156" y1="12" x2="156" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="156" x2="228" y2="156" stroke="#000" stroke-width="1.5"/><line x1="180" y1="12" x2="180" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="180" x2="228" y2="180" stroke="#000" stroke-width="1.5"/><line x1="204" y1="12" x2="204" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="204" x2="228" y2="204" stroke="#000" stroke-width="1.5"/><line x1="228" y1="12" x2="228" y2="228" stroke="#000" stroke-width="1.5"/><line x1="12" y1="228" x2="228" y2="228" stroke="#000" stroke-width="1.5"/></svg>',
  'ornament.svg',
  'Ornament z tmavých čtverců v síti 9 krát 9, pět čtverců je označeno písmeny A až E.',
  'Ornament v čtvercové síti',
  new List<String>{'Odebráním čtverce $D$ zůstane ornament, který stále není souměrný podle žádné osy (svislé, vodorovné ani šikmé). U ostatních čtverců by nový ornament některou osu souměrnosti získal.'},
  'D) čtverec $D$',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
