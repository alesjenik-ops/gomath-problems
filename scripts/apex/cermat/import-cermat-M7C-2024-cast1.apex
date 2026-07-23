String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD24C0T03';
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
  'CERMAT M7C 2024 – úloha 1',
  new List<String>{'Sedmina neznámého čísla je $7$.','Vypočítejte sedminásobek neznámého čísla.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Sedmina čísla je $7$, proto neznámé číslo je $7\\cdot 7=49$. Sedminásobek je $49\\cdot 7=343$.'},
  '$343$',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2024 – úloha 2.1',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\frac{4}{5}-\\frac{7}{4}\\cdot\\left(2-\\frac{4}{7}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'V závorce $2-\\frac{4}{7}=\\frac{10}{7}$. Dále $\\frac{7}{4}\\cdot\\frac{10}{7}=\\frac{10}{4}=\\frac{5}{2}$. Nakonec $\\frac{4}{5}-\\frac{5}{2}=\\frac{8}{10}-\\frac{25}{10}=-\\frac{17}{10}$.'},
  '$-\\frac{17}{10}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2024 – úloha 2.2',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\dfrac{\\frac{4}{9}\\cdot 2}{\\frac{5}{3}:3+3}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{4}{9}\\cdot 2=\\frac{8}{9}$. Jmenovatel: $\\frac{5}{3}:3+3=\\frac{5}{9}+3=\\frac{32}{9}$. Podíl $\\frac{8}{9}:\\frac{32}{9}=\\frac{8}{32}=\\frac{1}{4}$.'},
  '$\\frac{1}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2024 – úloha 3.1',
  new List<String>{'Vypočítejte. Uveďte celý postup řešení.','$0{,}7\\cdot 0{,}8+0{,}8\\cdot 1{,}3=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}7\\cdot 0{,}8+0{,}8\\cdot 1{,}3=0{,}56+1{,}04=1{,}6$. (Nebo $0{,}8\\cdot(0{,}7+1{,}3)=0{,}8\\cdot 2=1{,}6$.)'},
  '$1{,}6$',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2024 – úloha 3.2',
  new List<String>{'Vypočítejte. Uveďte celý postup řešení.','$1{,}5+0{,}5\\cdot(12-8)-2{,}5:5=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}5+0{,}5\\cdot(12-8)-2{,}5:5=1{,}5+0{,}5\\cdot 4-0{,}5=1{,}5+2-0{,}5=3$.'},
  '$3$',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2024 – úloha 4.1',
  new List<String>{'Od rybníka k hradu vedou dvě turistické cesty. Modrá je o třetinu kratší než červená. Obě cesty se liší o $3$ km.','Jaká je délka červené trasy? Výsledek uveďte v kilometrech.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Modrá je $\\frac{2}{3}$ délky červené, rozdíl délek je $\\frac{1}{3}$ červené. Platí $\\frac{1}{3}$ červené $=3$ km, tedy červená $=9$ km.'},
  '$9$ km',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2024 – úloha 4.2',
  new List<String>{'Na sídlišti se stala porucha vodovodního potrubí, proto byla ráno přistavena cisterna s pitnou vodou o objemu $40$ hektolitrů. Podnikatel z ní v průběhu dne odčerpal vodu do dvou barelů po $1\\,250$ litrech. Do večera ještě lidé odebrali $70$ dvacetilitrových kanystrů.','Kolik litrů vody zbylo večer v přistavené cisterně?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$40$ hektolitrů $=4000$ litrů. Podnikatel odčerpal $2\\cdot 1250=2500$ l, lidé odebrali $70\\cdot 20=1400$ l. Zbylo $4000-2500-1400=100$ l.'},
  '$100$ litrů',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
