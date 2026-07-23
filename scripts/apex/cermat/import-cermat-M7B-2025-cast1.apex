String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M7B 2025 – úloha 1',
  new List<String>{'Když osminu neznámého čísla zvětšíme o 16, výsledek bude o 1 větší než polovina neznámého čísla.','Určete neznámé číslo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme neznámé číslo $x$. Platí $\\frac{x}{8}+16=\\frac{x}{2}+1$, odtud $15=\\frac{x}{2}-\\frac{x}{8}=\\frac{3x}{8}$, tedy $x=40$.'},
  '$40$',
  2, 3, '2',
  new List<String>{'zs2','r7','rovnice','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2025 – úloha 2',
  new List<String>{'Čísla v tabulce se řadí zleva doprava od nejmenšího po největší a každá dvě čísla v sousedních polích tabulky jsou ve stejném poměru jako dvě uvedená čísla 72 a 108.','Určete čísla, která patří do prvního a posledního pole tabulky.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 110" font-family="sans-serif"> <rect x="20" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="3"/> <rect x="80" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/> <rect x="140" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/> <rect x="200" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/> <rect x="260" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="1"/> <rect x="320" y="30" width="60" height="50" fill="none" stroke="#000" stroke-width="3"/> <text x="170" y="61" font-size="18" text-anchor="middle">72</text> <text x="230" y="61" font-size="18" text-anchor="middle">108</text> </svg>',
  'tabulka.svg',
  'Tabulka se šesti poli; ve třetím poli je 72, ve čtvrtém 108, ostatní pole jsou prázdná.',
  'Tabulka k úloze 2',
  new List<String>{'Poměr sousedních čísel je $108:72=3:2$. Doleva dělíme poměrem $\\frac{3}{2}$: druhé pole $72:\\frac{3}{2}=48$, první pole $48:\\frac{3}{2}=32$. Doprava násobíme: páté pole $108\\cdot\\frac{3}{2}=162$, poslední pole $162\\cdot\\frac{3}{2}=243$.'},
  '$32$; $243$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2025 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\frac{1}{2}:\\frac{3}{4}-\\frac{3}{4}:\\frac{1}{2}+\\left(4-3\\cdot\\frac{4}{3}\\right):\\frac{1}{2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{2}:\\frac{3}{4}=\\frac{2}{3}$; $\\frac{3}{4}:\\frac{1}{2}=\\frac{3}{2}$; $4-3\\cdot\\frac{4}{3}=0$, takže $0:\\frac{1}{2}=0$. Celkem $\\frac{2}{3}-\\frac{3}{2}=\\frac{4}{6}-\\frac{9}{6}=-\\frac{5}{6}$.'},
  '$-\\frac{5}{6}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2025 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\dfrac{\\frac{0{,}5}{2}-2}{0{,}5\\cdot(2+0{,}5)-2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{0{,}5}{2}-2=0{,}25-2=-\\frac{7}{4}$. Jmenovatel: $0{,}5\\cdot 2{,}5-2=1{,}25-2=-\\frac{3}{4}$. Podíl $-\\frac{7}{4}:\\left(-\\frac{3}{4}\\right)=\\frac{7}{3}$.'},
  '$\\frac{7}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2025 – úloha 4',
  new List<String>{'U vodní nádrže jsou 4 stejně výkonná čerpadla, která pracují rovnoměrně. Prázdnou nádrž by všechna 4 čerpadla společně naplnila za 6 hodin. Ráno nebyla nádrž zcela prázdná, a všechna 4 čerpadla ji tak společně doplnila už za 4 hodiny.','4.1 Vyjádřete zlomkem v základním tvaru, jaká část objemu nádrže byla ráno naplněna vodou, než začala pracovat čerpadla.','4.2 Určete, kolik takových čerpadel by společně naplnilo prázdnou nádrž za 8 hodin.','4.3 Určete, za kolik hodin by jednu polovinu nádrže společně naplnila 2 taková čerpadla.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Čtyři čerpadla naplní za 4 hodiny $\\frac{4}{6}=\\frac{2}{3}$ nádrže; ráno tedy byla naplněna zbývající $\\frac{1}{3}$ nádrže.','4.2 Jedno čerpadlo naplní za hodinu $\\frac{1}{24}$ nádrže. Aby $n$ čerpadel naplnilo nádrž za 8 hodin, platí $n\\cdot\\frac{1}{24}\\cdot 8=1$, tedy $n=3$.','4.3 Dvě čerpadla naplní za hodinu $\\frac{2}{24}=\\frac{1}{12}$ nádrže; polovinu naplní za $\\frac{1}{2}:\\frac{1}{12}=6$ hodin.'},
  '4.1: $\\frac{1}{3}$; 4.2: $3$ čerpadla; 4.3: za $6$ hodin',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
