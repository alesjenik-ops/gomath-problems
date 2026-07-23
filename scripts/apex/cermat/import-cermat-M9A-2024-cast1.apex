String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD24C0T01';
Integer YEAR = 2024;

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
  'CERMAT M9A 2024 – úloha 1',
  new List<String>{'Pět švadlen, které šijí oblečení, pracují stejným tempem. Tyto švadleny splní danou zakázku za $24$ hodin.','Za jakou dobu splní o polovinu větší zakázku čtyři švadleny?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Práce na zakázce odpovídá $5\\cdot 24=120$ švadlenohodinám. Zakázka o polovinu větší představuje $1{,}5\\cdot 120=180$ švadlenohodin. Čtyři švadleny ji splní za $180:4=45$ hodin.'},
  '$45$ hodin',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2024 – úloha 2',
  new List<String>{'Skleněné těžítko má tvar rotačního válce s poloměrem podstavy $10$ cm a výškou $12$ cm. Vnější část těžítka je z čirého skla, uvnitř je část z modrého skla, která má také tvar rotačního válce, a to s poloměrem podstavy $5$ cm a výškou $8$ cm.','Vypočítejte objem čirého skla v těžítku. Výsledek zaokrouhlete na desítky cm³. Pro výpočet použijte zaokrouhlenou hodnotu čísla $\\pi$ z tabulky ($\\pi \\approx 3{,}14$).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 250" font-family="sans-serif"> <ellipse cx="150" cy="45" rx="95" ry="20" fill="#f2f2f2" stroke="#000"/> <line x1="55" y1="45" x2="55" y2="195" stroke="#000"/> <line x1="245" y1="45" x2="245" y2="195" stroke="#000"/> <path d="M55 195 A95 20 0 0 0 245 195" fill="none" stroke="#000"/> <path d="M55 195 A95 20 0 0 1 245 195" fill="none" stroke="#000" stroke-dasharray="4 4"/> <ellipse cx="150" cy="80" rx="45" ry="10" fill="#a9c1e0" stroke="#000"/> <line x1="105" y1="80" x2="105" y2="158" stroke="#000"/> <line x1="195" y1="80" x2="195" y2="158" stroke="#000"/> <path d="M105 158 A45 10 0 0 0 195 158" fill="#a9c1e0" stroke="#000"/> <path d="M105 158 A45 10 0 0 1 195 158" fill="none" stroke="#000" stroke-dasharray="3 3"/> <text x="258" y="128" font-size="13">12 cm</text> <text x="150" y="122" font-size="12" text-anchor="middle" fill="#333">8 cm</text> </svg>',
  'tezitko-valec.svg',
  'Rotační válec (těžítko) s vnitřním menším válcem z modrého skla.',
  'Schematický nákres těžítka (rozměry dle zadání)',
  new List<String>{'Objem celého válce: $V=\\pi\\cdot 10^2\\cdot 12=3{,}14\\cdot 100\\cdot 12=3768$ cm³. Objem modrého válce: $V_m=\\pi\\cdot 5^2\\cdot 8=3{,}14\\cdot 25\\cdot 8=628$ cm³. Objem čirého skla: $3768-628=3140$ cm³.'},
  '$3\\,140$ cm³',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2024 – úloha 3.1',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\left(2:\\dfrac{3}{2}\\right):\\dfrac{1}{2}+\\left(\\dfrac{5}{6}:\\dfrac{3}{4}\\right):\\dfrac{2}{3}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(2:\\frac{3}{2}\\right):\\frac{1}{2}=\\frac{4}{3}:\\frac{1}{2}=\\frac{8}{3}$. Dále $\\left(\\frac{5}{6}:\\frac{3}{4}\\right):\\frac{2}{3}=\\frac{10}{9}:\\frac{2}{3}=\\frac{10}{9}\\cdot\\frac{3}{2}=\\frac{5}{3}$. Součet: $\\frac{8}{3}+\\frac{5}{3}=\\frac{13}{3}$.'},
  '$\\dfrac{13}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 3.2',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\dfrac{\\frac{13}{10}-1{,}4}{\\frac{2}{15}+\\frac{1}{6}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{13}{10}-1{,}4=1{,}3-1{,}4=-\\frac{1}{10}$. Jmenovatel: $\\frac{2}{15}+\\frac{1}{6}=\\frac{4}{30}+\\frac{5}{30}=\\frac{9}{30}=\\frac{3}{10}$. Podíl: $-\\frac{1}{10}:\\frac{3}{10}=-\\frac{1}{3}$.'},
  '$-\\dfrac{1}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 4.1',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$\\left(a-\\dfrac{a}{4}\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(a-\\frac{a}{4}\\right)^2=\\left(\\frac{3a}{4}\\right)^2=\\frac{9}{16}a^2$.'},
  '$\\dfrac{9}{16}a^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 4.2',
  new List<String>{'Rozložte na součin podle vzorce:','$9a^2-16=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$9a^2-16=(3a)^2-4^2=(3a-4)\\cdot(3a+4)$.'},
  '$(3a-4)\\cdot(3a+4)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
