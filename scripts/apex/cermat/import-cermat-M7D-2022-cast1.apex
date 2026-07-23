String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD22C0T04';
Integer YEAR = 2022;

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
  'CERMAT M7D 2022 – úloha 1',
  new List<String>{'Vypište všechny dělitele čísla $95$, které jsou větší než $1$ a menší než $95$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$95=5\\cdot 19$. Dělitelé čísla $95$ jsou $1$, $5$, $19$, $95$. Mezi $1$ a $95$ tedy leží $5$ a $19$.'},
  '$5$; $19$',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2022 – úloha 2.1',
  new List<String>{'Vypočtěte: $(-3)\\cdot(-3)-5\\cdot 5-4\\cdot(-4)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(-3)\\cdot(-3)=9$, $5\\cdot 5=25$, $4\\cdot(-4)=-16$. Tedy $9-25-(-16)=9-25+16=0$.'},
  '$0$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2022 – úloha 2.2',
  new List<String>{'Vypočtěte: $(0{,}08-1):0{,}2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}08-1=-0{,}92$; $(-0{,}92):0{,}2=-4{,}6$.'},
  '$-4{,}6$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2022 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{12}{5}\\cdot\\frac{3}{20}-\\frac{3}{20}\\right):\\frac{7}{25}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{12}{5}\\cdot\\frac{3}{20}=\\frac{36}{100}=\\frac{9}{25}$; $\\frac{9}{25}-\\frac{3}{20}=\\frac{36-15}{100}=\\frac{21}{100}$; $\\frac{21}{100}:\\frac{7}{25}=\\frac{21}{100}\\cdot\\frac{25}{7}=\\frac{3}{4}$.'},
  '$\\frac{3}{4}$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2022 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{12}{\\,2+\\frac{2}{3}\\,}\\cdot\\dfrac{2\\cdot\\frac{2}{3}}{18}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2+\\frac{2}{3}=\\frac{8}{3}$, takže $\\frac{12}{8/3}=12\\cdot\\frac{3}{8}=\\frac{9}{2}$. Dále $2\\cdot\\frac{2}{3}=\\frac{4}{3}$, takže $\\frac{4/3}{18}=\\frac{4}{54}=\\frac{2}{27}$. Součin: $\\frac{9}{2}\\cdot\\frac{2}{27}=\\frac{18}{54}=\\frac{1}{3}$.'},
  '$\\frac{1}{3}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
