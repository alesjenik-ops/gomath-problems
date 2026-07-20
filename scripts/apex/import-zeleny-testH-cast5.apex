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
  'Zelený H11 – technické vysoké školy (koláčové grafy)',
  new List<String>{'Do dvou let po přijetí ke studiu technických vysokých škol ukončí své studium celkem $40\\,\\%$ studentů.','V prvním grafu je uvedena struktura přijatých na technické vysoké školy podle toho, jaký typ střední školy přijatí absolvovali. V druhém grafu je uvedena struktura těchto studentů po dvou letech studia vysoké školy.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Podíl gymnazistů mezi studenty technických vysokých škol se po dvou letech studia zvýšil o polovinu.','11.2 Během dvou let po nástupu ke studiu ukončilo své studium $60\\,\\%$ absolventů průmyslovek, ale jen $30\\,\\%$ gymnazistů.','11.3 Celkem $45\\,\\%$ těch, kteří do dvou let po nástupu ke studiu své studium ukončili, tvořili absolventi průmyslovek.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif"> <text x="120" y="24" font-size="15" text-anchor="middle" font-weight="bold">PŘIJATÍ KE STUDIU</text> <text x="370" y="24" font-size="14" text-anchor="middle" font-weight="bold">STUDENTI PO 2 LETECH</text> <path d="M120 130 L120 55 A75 75 0 0 1 164 191 Z" fill="#eeeeee" stroke="#000"/> <path d="M120 130 L164 191 A75 75 0 0 1 48.7 153.2 Z" fill="#bbbbbb" stroke="#000"/> <path d="M120 130 L48.7 153.2 A75 75 0 0 1 75.9 69.3 Z" fill="#888888" stroke="#000"/> <path d="M120 130 L75.9 69.3 A75 75 0 0 1 120 55 Z" fill="#444444" stroke="#000"/> <text x="162" y="120" font-size="13" text-anchor="middle">40 %</text> <text x="106" y="176" font-size="13" text-anchor="middle">30 %</text> <text x="77" y="120" font-size="13" text-anchor="middle" fill="#fff">20 %</text> <text x="106" y="91" font-size="13" text-anchor="middle" fill="#fff">10 %</text> <path d="M370 130 L370 55 A75 75 0 1 1 325.9 190.7 Z" fill="#eeeeee" stroke="#000"/> <path d="M370 130 L325.9 190.7 A75 75 0 0 1 298.7 106.8 Z" fill="#bbbbbb" stroke="#000"/> <path d="M370 130 L298.7 106.8 A75 75 0 0 1 346.8 58.7 Z" fill="#888888" stroke="#000"/> <path d="M370 130 L346.8 58.7 A75 75 0 0 1 370 55 Z" fill="#444444" stroke="#000"/> <text x="413" y="148" font-size="13" text-anchor="middle">60 %</text> <text x="327" y="148" font-size="13" text-anchor="middle">20 %</text> <text x="333" y="96" font-size="13" text-anchor="middle" fill="#fff">15 %</text> <text x="360" y="78" font-size="12" text-anchor="middle" fill="#fff">5 %</text> <rect x="30" y="250" width="14" height="14" fill="#eeeeee" stroke="#000"/><text x="48" y="262" font-size="13">GYMNÁZIA</text> <rect x="150" y="250" width="14" height="14" fill="#bbbbbb" stroke="#000"/><text x="168" y="262" font-size="13">PRŮMYSLOVKY</text> <rect x="300" y="250" width="14" height="14" fill="#888888" stroke="#000"/><text x="318" y="262" font-size="13">OSTATNÍ SOŠ</text> <rect x="30" y="278" width="14" height="14" fill="#444444" stroke="#000"/><text x="48" y="290" font-size="13">UČILIŠTĚ S MATURITOU</text> </svg>',
  'grafy-vs.svg',
  'Dva koláčové grafy: přijatí ke studiu (gymnázia 40, průmyslovky 30, ostatní SOŠ 20, učiliště 10 procent) a studenti po 2 letech (gymnázia 60, průmyslovky 20, ostatní SOŠ 15, učiliště 5 procent).',
  'Struktura přijatých a struktura studentů po 2 letech studia',
  new List<String>{'11.1 Podíl gymnazistů vzrostl ze $40\\,\\%$ na $60\\,\\%$, tj. $40\\cdot1{,}5=60$ — zvýšil se o polovinu. Pravda (Ano).','11.2 Z přijatých (na $100$) zůstává po dvou letech $60$: gymnazistů $36$, průmyslováků $12$. Studium ukončilo $\\frac{18}{30}=60\\,\\%$ průmyslováků, ale jen $\\frac{4}{40}=10\\,\\%$ gymnazistů (ne $30\\,\\%$). Nepravda (Ne).','11.3 Studium ukončilo celkem $40$ studentů, z toho průmyslováků $18$; $\\frac{18}{40}=45\\,\\%$. Pravda (Ano).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  3, 7, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
