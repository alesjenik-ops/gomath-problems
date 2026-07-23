String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD21C0T01';
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
  'CERMAT M7A 2021 – úloha 1',
  new List<String>{'Vypočtěte v dm² tři pětiny ze $4$ m².'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4$ m² $=400$ dm². Tři pětiny: $\\frac{3}{5}\\cdot 400=240$ dm².'},
  '$240$ dm²',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2021 – úloha 2.1',
  new List<String>{'Vypočtěte: $0{,}5+1{,}5\\cdot(10-4)-1{,}5:5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5+1{,}5\\cdot 6-0{,}3=0{,}5+9-0{,}3=9{,}2$.'},
  '$9{,}2$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2021 – úloha 2.2',
  new List<String>{'Vypočtěte: $0{,}4\\cdot 0{,}3-0{,}3\\cdot 1{,}6=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}12-0{,}48=-0{,}36$.'},
  '$-0{,}36$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2021 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\frac{1}{3}-\\frac{6}{5}\\cdot\\left(\\frac{5}{4}-\\frac{5}{6}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'V závorce: $\\frac{5}{4}-\\frac{5}{6}=\\frac{15-10}{12}=\\frac{5}{12}$.','Součin: $\\frac{6}{5}\\cdot\\frac{5}{12}=\\frac{1}{2}$. Celkem $\\frac{1}{3}-\\frac{1}{2}=-\\frac{1}{6}$.'},
  '$-\\frac{1}{6}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2021 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{\\frac{3}{10}}{\\frac{7}{2}:2+2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Jmenovatel: $\\frac{7}{2}:2+2=\\frac{7}{4}+2=\\frac{15}{4}$.','Podíl: $\\frac{3}{10}:\\frac{15}{4}=\\frac{3}{10}\\cdot\\frac{4}{15}=\\frac{12}{150}=\\frac{2}{25}$.'},
  '$\\frac{2}{25}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2021 – úloha 4.1',
  new List<String>{'Když neznámé číslo vynásobíme třemi, dostaneme stejné číslo, jako když vydělíme třemi číslo $234$.','Určete neznámé číslo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3x=234:3=78$, tedy $x=78:3=26$.'},
  '$26$',
  1, 2, '2',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2021 – úloha 4.2',
  new List<String>{'Adéla, Zora a Olda postupně zametli $1$ km dlouhý chodník. První část zametla Adéla, Zora pak zametla o $120$ m kratší část než Adéla a Olda zametl dvakrát delší část chodníku než Zora. (Každou část zametala pouze jedna osoba.)','Vypočtěte, kolik metrů chodníku zametla Adéla.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Adéla $a$, Zora $a-120$, Olda $2(a-120)$. Rovnice: $a+(a-120)+2(a-120)=1000$, tj. $4a-360=1000$, $a=340$.','Adéla zametla $340$ m (Zora $220$ m, Olda $440$ m).'},
  '$340$ m',
  2, 4, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
