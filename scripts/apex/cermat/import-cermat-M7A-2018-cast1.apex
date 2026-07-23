String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD18C0T01';
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
  'CERMAT M7A 2018 – úloha 1',
  new List<String>{'Zapište zlomkem v základním tvaru dvě pětiny z $\\frac{30}{24}$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Dvě pětiny z $\\frac{30}{24}$: $\\frac{2}{5}\\cdot\\frac{30}{24}=\\frac{60}{120}=\\frac{1}{2}$.'},
  '$\\frac{1}{2}$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2018 – úloha 2',
  new List<String>{'Vypočtěte.','2.1  $5\\cdot 0{,}6:0{,}012=$','2.2  $50-[2{,}7-(28{,}3+2{,}7)\\cdot 0]-28{,}3=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 $5\\cdot 0{,}6=3$, dále $3:0{,}012=250$.','2.2 $(28{,}3+2{,}7)\\cdot 0=0$, takže $50-[2{,}7-0]-28{,}3=50-2{,}7-28{,}3=19$.'},
  '2.1: $250$; 2.2: $19$',
  3, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2018 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\frac{4}{3}+3\\cdot\\left(\\frac{1}{3}-\\frac{3}{5}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{3}-\\frac{3}{5}=\\frac{5-9}{15}=-\\frac{4}{15}$; $3\\cdot\\left(-\\frac{4}{15}\\right)=-\\frac{4}{5}$; $\\frac{4}{3}-\\frac{4}{5}=\\frac{20-12}{15}=\\frac{8}{15}$.'},
  '$\\frac{8}{15}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2018 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{\\frac{5}{6}\\cdot\\frac{4}{35}}{1+\\frac{1}{3}-\\frac{2}{7}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{5}{6}\\cdot\\frac{4}{35}=\\frac{20}{210}=\\frac{2}{21}$. Jmenovatel: $1+\\frac{1}{3}-\\frac{2}{7}=\\frac{21+7-6}{21}=\\frac{22}{21}$. Podíl: $\\frac{2}{21}:\\frac{22}{21}=\\frac{2}{22}=\\frac{1}{11}$.'},
  '$\\frac{1}{11}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2018 – úloha 4',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','4.1  $2$ m² $-\\,50$ cm² $=\\;?\\;$ dm²','4.2  $(5-?)$ minuty $-\\,15$ sekund $=75$ sekund'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 $2$ m² $=200$ dm² a $50$ cm² $=0{,}5$ dm²; $200-0{,}5=199{,}5$ dm².','4.2 $75+15=90$ sekund $=1{,}5$ minuty; z rovnosti $5-?=1{,}5$ plyne $?=3{,}5$.'},
  '4.1: $199{,}5$; 4.2: $3{,}5$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2018 – úloha 5',
  new List<String>{'Farmář Malý plní svou úrodu pšenice do malých pytlů. Do každého pytle se vejde $30$ kg pšenice. Již tři čtvrtiny své úrody má v pytlích a na hromadě mu zbývá posledních $150$ kg pšenice. Farmář Velký má o polovinu větší úrodu pšenice než farmář Malý. Celou svou úrodu již uskladnil ve velkých pytlích, do každého nasypal $50$ kg pšenice.','5.1 Vypočtěte, kolik malých pytlů pšenice již farmář Malý naplnil.','5.2 Vypočtěte, v kolika velkých pytlích uskladnil celou svou úrodu farmář Velký.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 190" font-family="sans-serif" font-size="13"> <text x="150" y="18" text-anchor="middle">Farmář Malý (pytle po 30 kg)</text> <text x="420" y="18" text-anchor="middle">Farmář Velký (pytle po 50 kg)</text> <rect x="30" y="30" width="250" height="140" fill="none" stroke="#000"/> <rect x="300" y="30" width="250" height="140" fill="none" stroke="#000"/> <g stroke="#000" fill="#f0f0f0"> <ellipse cx="70" cy="105" rx="19" ry="34"/><ellipse cx="118" cy="105" rx="19" ry="34"/><ellipse cx="166" cy="105" rx="19" ry="34"/> </g> <text x="200" y="112" font-size="18">...</text> <rect x="232" y="118" width="34" height="42" fill="#b9b9b9" stroke="#000"/> <text x="150" y="185" text-anchor="middle" font-size="12">zbývá 150 kg</text> <g stroke="#000" fill="#f0f0f0"> <ellipse cx="345" cy="100" rx="23" ry="42"/><ellipse cx="410" cy="100" rx="23" ry="42"/><ellipse cx="475" cy="100" rx="23" ry="42"/> </g> <text x="510" y="108" font-size="18">...</text> </svg>',
  'pytle.svg',
  'Schéma: vlevo pytle farmáře Malého se zbývající hromadou 150 kg, vpravo pytle farmáře Velkého.',
  'Výchozí obrázek k úloze 5 (schematicky)',
  new List<String>{'Zbývajících $150$ kg je jedna čtvrtina úrody Malého, celá úroda je tedy $4\\cdot 150=600$ kg; v pytlích má tři čtvrtiny, tj. $\\frac{3}{4}\\cdot 600=450$ kg.','5.1 Malých pytlů po $30$ kg: $450:30=15$ pytlů.','5.2 Úroda Velkého $=1{,}5\\cdot 600=900$ kg; velkých pytlů po $50$ kg: $900:50=18$ pytlů.'},
  '5.1: $15$ pytlů; 5.2: $18$ pytlů',
  4, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
