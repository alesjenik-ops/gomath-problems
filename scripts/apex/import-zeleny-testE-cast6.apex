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
  'Zelený E16 – houpačky v rovnováze',
  new List<String>{'Na obrázku jsou čtyři houpačky. Na pravé straně každé z nich jsou ve vyznačené vzdálenosti od vzpěry umístěny kameny, každý o hmotnosti $40$ kg (shora dolů $3$, $3$, $1$ a $6$ kamenů). Na levou stranu každé houpačky je třeba ve vyznačené vzdálenosti umístit kameny tak, aby houpačky zůstaly v rovnovážné poloze.','16.1 Vypočtěte celkovou hmotnost kamenů potřebných k tomu, aby všechny čtyři houpačky byly v rovnovážné poloze.','16.2 Vypočtěte, kolik bude třeba na vyvážení houpaček kamenů, víme-li, že máme k dispozici kameny o hmotnosti $40$ kg, $20$ kg a $10$ kg a desetikilogramových je třiapůlkrát více než kamenů o hmotnosti $20$ kg.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 560" font-family="sans-serif"> <line x1="60" y1="100" x2="440" y2="100" stroke="#000" stroke-width="3"/> <polygon points="250,100 236,132 264,132" fill="#000"/> <rect x="108" y="76" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/> <text x="122" y="92" font-size="15" text-anchor="middle">?</text> <rect x="340" y="78" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="340" y="88" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="340" y="98" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="122" y1="58" x2="250" y2="58" stroke="#444" stroke-width="1"/> <text x="186" y="53" font-size="13" text-anchor="middle">1,5 m</text> <line x1="250" y1="48" x2="357" y2="48" stroke="#444" stroke-width="1"/> <text x="304" y="43" font-size="13" text-anchor="middle">1 m</text> <line x1="60" y1="230" x2="440" y2="230" stroke="#000" stroke-width="3"/> <polygon points="250,230 236,262 264,262" fill="#000"/> <rect x="150" y="206" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/> <text x="164" y="222" font-size="15" text-anchor="middle">?</text> <rect x="340" y="208" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="340" y="218" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="340" y="228" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="164" y1="188" x2="250" y2="188" stroke="#444" stroke-width="1"/> <text x="207" y="183" font-size="13" text-anchor="middle">0,9 m</text> <line x1="250" y1="178" x2="357" y2="178" stroke="#444" stroke-width="1"/> <text x="304" y="173" font-size="13" text-anchor="middle">1,2 m</text> <line x1="60" y1="360" x2="440" y2="360" stroke="#000" stroke-width="3"/> <polygon points="250,360 236,392 264,392" fill="#000"/> <rect x="184" y="336" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/> <text x="198" y="352" font-size="15" text-anchor="middle">?</text> <rect x="376" y="349" width="40" height="10" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="198" y1="318" x2="250" y2="318" stroke="#444" stroke-width="1"/> <text x="224" y="313" font-size="13" text-anchor="middle">50 cm</text> <line x1="250" y1="308" x2="395" y2="308" stroke="#444" stroke-width="1"/> <text x="322" y="303" font-size="13" text-anchor="middle">2 m</text> <line x1="60" y1="500" x2="440" y2="500" stroke="#000" stroke-width="3"/> <polygon points="250,500 236,532 264,532" fill="#000"/> <rect x="98" y="476" width="28" height="22" fill="none" stroke="#000" stroke-width="1.5"/> <text x="112" y="492" font-size="15" text-anchor="middle">?</text> <rect x="348" y="438" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="348" y="448" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="348" y="458" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="348" y="468" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="348" y="478" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="348" y="488" width="34" height="9" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="112" y1="458" x2="250" y2="458" stroke="#444" stroke-width="1"/> <text x="181" y="453" font-size="13" text-anchor="middle">180 cm</text> <line x1="250" y1="448" x2="365" y2="448" stroke="#444" stroke-width="1"/> <text x="308" y="443" font-size="13" text-anchor="middle">1,5 m</text> </svg>',
  'houpacky.svg',
  'Čtyři páky (houpačky). Zleva vzdálenosti a počty kamenů: 1,5 m / 1 m (3 kameny); 0,9 m / 1,2 m (3 kameny); 50 cm / 2 m (1 kámen); 180 cm / 1,5 m (6 kamenů).',
  'Čtyři houpačky s vyznačenými vzdálenostmi',
  new List<String>{'Rovnováha páky: hmotnost krát vzdálenost vlevo = hmotnost krát vzdálenost vpravo.','1. houpačka: $m\\cdot1{,}5=3\\cdot40\\cdot1\\Rightarrow m=80$ kg. 2.: $m\\cdot0{,}9=3\\cdot40\\cdot1{,}2\\Rightarrow m=160$ kg. 3.: $m\\cdot0{,}5=40\\cdot2\\Rightarrow m=160$ kg. 4.: $m\\cdot1{,}8=6\\cdot40\\cdot1{,}5\\Rightarrow m=200$ kg.','16.1 Celkem $80+160+160+200=600$ kg.','16.2 Nechť je $y$ kamenů po $20$ kg a $z=3{,}5y$ kamenů po $10$ kg a $x$ kamenů po $40$ kg. Z $40x+20y+10z=600$ a $z=3{,}5y$ dostaneme $y=8$, $z=28$, $x=4$. Celkem $4+8+28=40$ kamenů.'},
  '16.1: $600$ kg; 16.2: $40$ kamenů',
  6, 9, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
