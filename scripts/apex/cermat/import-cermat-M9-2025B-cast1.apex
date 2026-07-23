String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD25C0T02';
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
  'CERMAT M9B 2025 - uloha 1',
  new List<String>{'Cena detske vstupenky do muzea je rovna dvema petinam ceny vstupenky pro dospeleho. Jeden dospely se tremi detmi zaplatil za vstupenky 330 korun.','Vypoctete v korunach cenu jedne detske vstupenky.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Cena pro dospeleho $d$, detska $\\frac{2}{5}d$. Rovnice $d+3\\cdot\\frac{2}{5}d=330$, tj. $\\frac{11}{5}d=330$, odtud $d=150$ korun. Detska vstupenka stoji $\\frac{2}{5}\\cdot 150=60$ korun.'},
  '$60$ korun',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9B 2025 - uloha 2',
  new List<String>{'Vypoctete druhou odmocninu ze soucinu smisenych cisel $6\\frac{1}{4}$ a $2\\frac{7}{9}$. Vysledek zapiste zlomkem v zakladnim tvaru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$6\\frac{1}{4}=\\frac{25}{4}$, $2\\frac{7}{9}=\\frac{25}{9}$. Soucin $\\frac{25}{4}\\cdot\\frac{25}{9}=\\frac{625}{36}$. Odmocnina $\\sqrt{\\frac{625}{36}}=\\frac{25}{6}$.'},
  '$\\frac{25}{6}$',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 3.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:','$\\left(\\frac{11}{5}-\\frac{11}{6}\\right):\\left(-\\frac{1}{3}\\right)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{11}{5}-\\frac{11}{6}=\\frac{66-55}{30}=\\frac{11}{30}$. Deleni: $\\frac{11}{30}:\\left(-\\frac{1}{3}\\right)=\\frac{11}{30}\\cdot(-3)=-\\frac{11}{10}$.'},
  '$-\\frac{11}{10}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 3.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:','$\\frac{20-\\sqrt{4\\cdot 3^2}}{3\\cdot\\sqrt{100-64}}:\\frac{4+3}{4\\cdot 3}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel $20-\\sqrt{4\\cdot 9}=20-6=14$, jmenovatel $3\\cdot\\sqrt{36}=18$, tedy $\\frac{14}{18}=\\frac{7}{9}$. Dale $\\frac{7}{9}:\\frac{7}{12}=\\frac{7}{9}\\cdot\\frac{12}{7}=\\frac{12}{9}=\\frac{4}{3}$.'},
  '$\\frac{4}{3}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 4.1',
  new List<String>{'Upravte na co nejjednodussi tvar bez zavorek:','$x\\cdot 3x-2x\\cdot 3-(x-3)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3x^2-6x-(x^2-6x+9)=3x^2-6x-x^2+6x-9=2x^2-9$.'},
  '$2x^2-9$',
  1, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 4.2',
  new List<String>{'Upravte a vysledny vyraz rozlozte na soucin vytknutim:','$(2k)^2-k\\cdot(1+2k)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(2k)^2-k\\cdot(1+2k)=4k^2-k-2k^2=2k^2-k=k\\cdot(2k-1)$.'},
  '$k\\cdot(2k-1)$',
  1, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 4.3',
  new List<String>{'Upravte na co nejjednodussi tvar bez zavorek:','$7a\\cdot(a+3)+2\\cdot(1-3a)\\cdot(a+5)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$7a\\cdot(a+3)=7a^2+21a$. $2\\cdot(1-3a)\\cdot(a+5)=2\\cdot(a+5-3a^2-15a)=2\\cdot(-3a^2-14a+5)=-6a^2-28a+10$. Soucet: $7a^2+21a-6a^2-28a+10=a^2-7a+10$.'},
  '$a^2-7a+10$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 5.1',
  new List<String>{'Reste rovnici:','$\\frac{7}{12}x+2\\cdot\\left(\\frac{3}{8}x-1\\right)=-3\\cdot\\left(\\frac{x}{9}+1\\right)$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Roznasobenim: $\\frac{7}{12}x+\\frac{3}{4}x-2=-\\frac{1}{3}x-3$. Vlevo $\\frac{7}{12}x+\\frac{9}{12}x=\\frac{4}{3}x$. Rovnice $\\frac{4}{3}x-2=-\\frac{1}{3}x-3$, odtud $\\frac{5}{3}x=-1$, tedy $x=-\\frac{3}{5}$.'},
  '$x=-\\frac{3}{5}$',
  2, 5, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 5.2',
  new List<String>{'Reste soustavu rovnic:','$6x+y=14$','$3x+2y=1$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Z prvni rovnice $y=14-6x$. Dosazenim: $3x+2(14-6x)=1$, tj. $3x+28-12x=1$, $-9x=-27$, $x=3$. Pak $y=14-18=-4$.'},
  '$x=3$; $y=-4$',
  2, 5, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
