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
  'Zelený G16 – věk maminek (koláčové grafy)',
  new List<String>{'Do posledního ročníku chodí $100$ žáků, chlapců je však o třetinu méně než děvčat (tj. $40$ chlapců a $60$ dívek). Zaznamenali jsme, kolik procent chlapců a kolik procent dívek má mámu v určitém věku (pětileté intervaly), viz grafy.','Na základě informací nahraďte v následujících větách (16.1–16.3) symbol ***** správným výrazem nebo číslem.','16.1 Mírně přes jednu ***** žáků (chlapců i dívek dohromady) má mámu ve věku $50$ a více let.','16.2 Celkem ***** $\\%$ z nás má mámu ve věku 40–49 let. Dívek je v této skupině o něco více než *****krát tolik.','16.3 Téměř ***** všech žáků (chlapců i dívek dohromady) posledního ročníku má mámu mladší $40$ let.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 430" font-family="sans-serif"> <text x="150" y="30" font-size="18" font-weight="bold" text-anchor="middle">CHLAPCI</text> <text x="570" y="30" font-size="18" font-weight="bold" text-anchor="middle">DIVKY</text> <path d="M 150 170 L 150 75 A 95 95 0 0 1 205.8 93.1 Z" fill="#d9d9d9" stroke="#ffffff" stroke-width="1.5"/> <path d="M 150 170 L 205.8 93.1 A 95 95 0 0 1 226.9 114.2 Z" fill="#bdbdbd" stroke="#ffffff" stroke-width="1.5"/> <path d="M 150 170 L 226.9 114.2 A 95 95 0 0 1 205.8 246.9 Z" fill="#9a9a9a" stroke="#ffffff" stroke-width="1.5"/> <path d="M 150 170 L 205.8 246.9 A 95 95 0 0 1 73.1 225.8 Z" fill="#767676" stroke="#ffffff" stroke-width="1.5"/> <path d="M 150 170 L 73.1 225.8 A 95 95 0 0 1 73.1 114.2 Z" fill="#515151" stroke="#ffffff" stroke-width="1.5"/> <path d="M 150 170 L 73.1 114.2 A 95 95 0 0 1 150 75 Z" fill="#2b2b2b" stroke="#ffffff" stroke-width="1.5"/> <text x="184.3" y="65.4" font-size="15" text-anchor="middle">10%</text> <text x="228.5" y="92.5" font-size="15" text-anchor="middle">5%</text> <text x="259.6" y="188.4" font-size="15" text-anchor="middle">25%</text> <text x="132.6" y="280.6" font-size="15" text-anchor="middle">25%</text> <text x="39" y="171" font-size="15" text-anchor="middle">20%</text> <text x="99.6" y="72.1" font-size="15" text-anchor="middle">15%</text> <path d="M 570 170 L 570 75 A 95 95 0 0 1 599.4 79.6 Z" fill="#d9d9d9" stroke="#ffffff" stroke-width="1.5"/> <path d="M 570 170 L 599.4 79.6 A 95 95 0 0 1 625.8 93.1 Z" fill="#bdbdbd" stroke="#ffffff" stroke-width="1.5"/> <path d="M 570 170 L 625.8 93.1 A 95 95 0 0 1 625.8 246.9 Z" fill="#9a9a9a" stroke="#ffffff" stroke-width="1.5"/> <path d="M 570 170 L 625.8 246.9 A 95 95 0 0 1 479.6 140.6 Z" fill="#767676" stroke="#ffffff" stroke-width="1.5"/> <path d="M 570 170 L 479.6 140.6 A 95 95 0 0 1 514.2 93.1 Z" fill="#515151" stroke="#ffffff" stroke-width="1.5"/> <path d="M 570 170 L 514.2 93.1 A 95 95 0 0 1 570 75 Z" fill="#2b2b2b" stroke="#ffffff" stroke-width="1.5"/> <text x="587.4" y="61.4" font-size="15" text-anchor="middle">5%</text> <text x="620.4" y="72.1" font-size="15" text-anchor="middle">5%</text> <text x="681" y="171" font-size="15" text-anchor="middle">30%</text> <text x="504.8" y="260.8" font-size="15" text-anchor="middle">40%</text> <text x="480.2" y="105.8" font-size="15" text-anchor="middle">10%</text> <text x="535.7" y="65.4" font-size="15" text-anchor="middle">10%</text> <rect x="230" y="330" width="20" height="20" fill="#d9d9d9" stroke="#000000" stroke-width="0.7"/> <text x="257" y="345" font-size="15">mene nez 35</text> <rect x="230" y="360" width="20" height="20" fill="#bdbdbd" stroke="#000000" stroke-width="0.7"/> <text x="257" y="375" font-size="15">35 - 39 let</text> <rect x="230" y="390" width="20" height="20" fill="#9a9a9a" stroke="#000000" stroke-width="0.7"/> <text x="257" y="405" font-size="15">40 - 44 let</text> <rect x="440" y="330" width="20" height="20" fill="#767676" stroke="#000000" stroke-width="0.7"/> <text x="467" y="345" font-size="15">45 - 49 let</text> <rect x="440" y="360" width="20" height="20" fill="#515151" stroke="#000000" stroke-width="0.7"/> <text x="467" y="375" font-size="15">50 - 54 let</text> <rect x="440" y="390" width="20" height="20" fill="#2b2b2b" stroke="#000000" stroke-width="0.7"/> <text x="467" y="405" font-size="15">55 a vice let</text> </svg>',
  'vek-mamin.svg',
  'Dva koláčové grafy: chlapci (10, 5, 25, 25, 20, 15 %) a dívky (5, 5, 30, 40, 10, 10 %) podle věku mámy v pětiletých intervalech od méně než 35 do 55 a více let.',
  'Věk maminek chlapců a dívek posledního ročníku',
  new List<String>{'16.1 Mámu $50$ a více let má u chlapců $35\\,\\%$ ze $40=14$, u dívek $20\\,\\%$ ze $60=12$; celkem $26$ ze $100$, tj. mírně přes jednu čtvrtinu.','16.2 Věk 40–49 let: chlapci $50\\,\\%$ ze $40=20$, dívky $70\\,\\%$ ze $60=42$; celkem $62$ ze $100=62\\,\\%$. Dívek ($42$) je o něco více než dvakrát tolik co chlapců ($20$).','16.3 Mámu mladší $40$ let má chlapců $15\\,\\%$ ze $40=6$, dívek $10\\,\\%$ ze $60=6$; celkem $12$ ze $100$, tj. téměř jednu osminu.'},
  '16.1: čtvrtinu ($26\\,\\%$); 16.2: $62\\,\\%$, dvakrát; 16.3: osminu ($12\\,\\%$)',
  6, 10, '4',
  new List<String>{'zs2','r9','statistika','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
