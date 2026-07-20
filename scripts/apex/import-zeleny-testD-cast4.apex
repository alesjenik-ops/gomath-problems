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
  'Zelený D11 – graf denních teplot (Ano/Ne)',
  new List<String>{'V grafu jsou zobrazeny nejvyšší a nejnižší denní teploty (ve stupních Celsia) v uplynulém týdnu.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).','11.1 Rozdíl mezi nejvyšší a nejnižší denní teplotou během týdne vzrostl o $80\\,\\%$.','11.2 Průměrná nejvyšší denní teplota byla v uplynulém týdnu $12$ °C.','11.3 Na počátku týdne vzrostla nejvyšší denní teplota během jednoho dne o $75\\,\\%$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 375" font-family="sans-serif"><line x1="58" y1="20" x2="500" y2="20" stroke="#ccc" stroke-width="1"/><text x="50" y="25" font-size="13" text-anchor="end">16</text><line x1="58" y1="80" x2="500" y2="80" stroke="#ccc" stroke-width="1"/><text x="50" y="85" font-size="13" text-anchor="end">12</text><line x1="58" y1="140" x2="500" y2="140" stroke="#ccc" stroke-width="1"/><text x="50" y="145" font-size="13" text-anchor="end">8</text><line x1="58" y1="200" x2="500" y2="200" stroke="#ccc" stroke-width="1"/><text x="50" y="205" font-size="13" text-anchor="end">4</text><line x1="58" y1="260" x2="500" y2="260" stroke="#ccc" stroke-width="1"/><text x="50" y="265" font-size="13" text-anchor="end">0</text><line x1="58" y1="320" x2="500" y2="320" stroke="#ccc" stroke-width="1"/><text x="50" y="325" font-size="13" text-anchor="end">-4</text><line x1="58" y1="20" x2="58" y2="320" stroke="#000" stroke-width="1.5"/><line x1="58" y1="260" x2="500" y2="260" stroke="#000" stroke-width="1.5"/><rect x="62" y="260" width="20" height="30" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="86" y="140" width="20" height="120" fill="#555" stroke="#222" stroke-width="0.8"/><text x="85" y="337" font-size="13" text-anchor="middle">Po</text><rect x="125" y="230" width="20" height="30" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="149" y="50" width="20" height="210" fill="#555" stroke="#222" stroke-width="0.8"/><text x="148" y="337" font-size="13" text-anchor="middle">Út</text><rect x="188" y="245" width="20" height="15" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="212" y="50" width="20" height="210" fill="#555" stroke="#222" stroke-width="0.8"/><text x="211" y="337" font-size="13" text-anchor="middle">St</text><rect x="251" y="260" width="20" height="15" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="275" y="65" width="20" height="195" fill="#555" stroke="#222" stroke-width="0.8"/><text x="274" y="337" font-size="13" text-anchor="middle">Čt</text><rect x="314" y="260" width="20" height="30" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="338" y="50" width="20" height="210" fill="#555" stroke="#222" stroke-width="0.8"/><text x="337" y="337" font-size="13" text-anchor="middle">Pá</text><rect x="377" y="260" width="20" height="45" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="401" y="65" width="20" height="195" fill="#555" stroke="#222" stroke-width="0.8"/><text x="400" y="337" font-size="13" text-anchor="middle">So</text><rect x="440" y="260" width="20" height="45" fill="#bbb" stroke="#666" stroke-width="0.8"/><rect x="464" y="35" width="20" height="225" fill="#555" stroke="#222" stroke-width="0.8"/><text x="463" y="337" font-size="13" text-anchor="middle">Ne</text><rect x="150" y="352" width="16" height="12" fill="#bbb" stroke="#666"/><text x="170" y="362" font-size="12">nejnižší</text><rect x="300" y="352" width="16" height="12" fill="#555" stroke="#222"/><text x="320" y="362" font-size="12">nejvyšší</text></svg>',
  'graf-teploty.svg',
  'Sloupcový graf nejnižších a nejvyšších denních teplot pro sedm dní týdne (pondělí až neděle).',
  'Nejvyšší a nejnižší denní teploty v uplynulém týdnu',
  new List<String>{'11.1 V pondělí je rozdíl $8-(-2)=10$ °C, v neděli $15-(-3)=18$ °C. Nárůst $\\frac{18}{10}=1{,}8$, tj. o $80\\,\\%$. Pravdivé (Ano).','11.2 Nejvyšší teploty jsou $8, 14, 14, 13, 14, 13, 15$; průměr $\\frac{91}{7}=13$ °C, nikoli $12$ °C. Nepravdivé (Ne).','11.3 Z pondělí ($8$ °C) na úterý ($14$ °C) je nárůst $\\frac{14}{8}=1{,}75$, tj. o $75\\,\\%$. Pravdivé (Ano).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  3, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
