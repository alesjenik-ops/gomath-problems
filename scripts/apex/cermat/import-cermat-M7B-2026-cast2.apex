String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD26C0T02';
Integer YEAR = 2026;

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
  'CERMAT M7B 2026 – úloha 4',
  new List<String>{'Na papírové ruličce je navinuta stuha delší než 9 m. Na volném konci stuhy je bílý proužek délky 6 cm, následuje červený proužek délky 6 cm a dále se tyto proužky pravidelně střídají. Od volného konce jsme odměřili a odstřihli část stuhy délky 1,7 metru na pomlázku.','Určete: 4.1 kolik červených proužků je na odstřižené části stuhy na pomlázku; 4.2 kolik cm měří první necelý proužek na volném konci stuhy navinuté na ruličce po odstřižení části stuhy.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 180" font-family="sans-serif"><circle cx="70" cy="85" r="48" fill="#e6e6e6" stroke="#000" stroke-width="2"/><circle cx="70" cy="85" r="14" fill="#fff" stroke="#000" stroke-width="2"/><rect x="130" y="70" width="40" height="30" fill="#ffffff" stroke="#000"/><rect x="170" y="70" width="40" height="30" fill="#b0b0b0" stroke="#000"/><rect x="210" y="70" width="40" height="30" fill="#ffffff" stroke="#000"/><rect x="250" y="70" width="40" height="30" fill="#b0b0b0" stroke="#000"/><rect x="290" y="70" width="40" height="30" fill="#ffffff" stroke="#000"/><rect x="330" y="70" width="40" height="30" fill="#b0b0b0" stroke="#000"/><rect x="370" y="70" width="40" height="30" fill="#ffffff" stroke="#000"/><rect x="410" y="70" width="40" height="30" fill="#b0b0b0" stroke="#000"/><line x1="130" y1="122" x2="170" y2="122" stroke="#000"/><polygon points="130,122 138,118 138,126" fill="#000"/><polygon points="170,122 162,118 162,126" fill="#000"/><text x="150.0" y="138" font-size="14" text-anchor="middle">6 cm</text><line x1="170" y1="144" x2="210" y2="144" stroke="#000"/><polygon points="170,144 178,140 178,148" fill="#000"/><polygon points="210,144 202,140 202,148" fill="#000"/><text x="190.0" y="160" font-size="14" text-anchor="middle">6 cm</text></svg>',
  'stuha.svg',
  'Rulička s navinutou stuhou; na volném konci se pravidelně střídají bílé a červené proužky po 6 cm.',
  'Stuha se střídajícími se proužky po 6 cm',
  new List<String>{'Odstřižená část měří $170$ cm. Proužky po $6$ cm: $170 : 6 = 28$ celých proužků (dohromady $168$ cm) a zbylé $2$ cm patří $29.$ proužku.','4.1 Bílý, červený, bílý, ... – červené jsou sudé proužky ($2., 4., \\ldots, 28.$), tj. $14$ červených. Necelý $29.$ proužek je bílý.','4.2 Odstřihli jsme $2$ cm z $29.$ (bílého) proužku, na ruličce z něj zbývá $6 - 2 = 4$ cm.'},
  '4.1: $14$ červených proužků; 4.2: $4$ cm',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2026 – úloha 5',
  new List<String>{'Farmář dal všechny sklizené cukety do beden. Naplnil 4 malé, 3 střední a 1 velkou bednu. Ve všech malých bednách byl stejný počet cuket, v každé střední bedně bylo o 30 cuket více než v malé bedně a ve velké bedně bylo 120 cuket. Ve skladu si farmář ponechal jednu velkou, jednu střední a jednu malou bednu s cuketami a zbývajících 310 cuket z ostatních beden prodal.','Určete: 5.1 počet cuket v jedné malé bedně; 5.2 celkový počet cuket, které farmář sklidil.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Malá bedna $x$ cuket, střední $x + 30$, velká $120$. Prodal cukety ze $3$ malých a $2$ středních beden: $3x + 2(x + 30) = 310$, tj. $5x + 60 = 310$, odtud $x = 50$.','5.1 V jedné malé bedně je $50$ cuket.','5.2 Celkem $4 \\cdot 50 + 3 \\cdot 80 + 120 = 200 + 240 + 120 = 560$ cuket.'},
  '5.1: $50$ cuket; 5.2: $560$ cuket',
  4, 5, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
