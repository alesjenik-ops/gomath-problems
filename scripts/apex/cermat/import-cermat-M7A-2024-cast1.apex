String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD24C0T01';
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
  'CERMAT M7A 2024 – úloha 1.1',
  new List<String>{'Máme čísla $A$ a $B$. $A=1{,}6$; $B=-1{,}2$.','Kolikrát je součet $A+B$ menší než rozdíl $A-B$?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Součet $A+B=1{,}6+(-1{,}2)=0{,}4$, rozdíl $A-B=1{,}6-(-1{,}2)=2{,}8$. Podíl $2{,}8:0{,}4=7$.'},
  '$7$krát',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2024 – úloha 1.2',
  new List<String>{'Napište desetinné číslo, které je o $0{,}093$ menší než $\\frac{7}{8}$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{7}{8}=0{,}875$; $0{,}875-0{,}093=0{,}782$.'},
  '$0{,}782$',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2024 – úloha 2.1',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{\\left(\\frac{5}{8}-\\frac{1}{6}\\right):\\frac{11}{12}}{4\\cdot\\frac{7}{8}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{5}{8}-\\frac{1}{6}=\\frac{15-4}{24}=\\frac{11}{24}$; $\\frac{11}{24}:\\frac{11}{12}=\\frac{11}{24}\\cdot\\frac{12}{11}=\\frac{1}{2}$. Jmenovatel: $4\\cdot\\frac{7}{8}=\\frac{7}{2}$. Celkem $\\frac{1}{2}:\\frac{7}{2}=\\frac{1}{2}\\cdot\\frac{2}{7}=\\frac{1}{7}$.'},
  '$\\frac{1}{7}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2024 – úloha 2.2',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','$2{,}5-\\frac{7}{8}\\cdot\\frac{4}{5}-\\frac{27}{18}:\\frac{15}{9}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{7}{8}\\cdot\\frac{4}{5}=\\frac{28}{40}=\\frac{7}{10}$; $\\frac{27}{18}:\\frac{15}{9}=\\frac{3}{2}\\cdot\\frac{3}{5}=\\frac{9}{10}$. Pak $2{,}5-\\frac{7}{10}-\\frac{9}{10}=\\frac{25}{10}-\\frac{7}{10}-\\frac{9}{10}=\\frac{9}{10}$.'},
  '$\\frac{9}{10}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2024 – úloha 3',
  new List<String>{'Na číselné ose se stejně velkými dílky jsou označeny obrazy čísel $1{,}4$ a $5{,}6$ a obrazy neznámých čísel $A$, $B$, $C$.','3.1 Zapište hodnotu čísla $C$.','3.2 Zapište, kolikrát je číslo $B$ větší než číslo $1{,}4$.','3.3 Vypočítejte rozdíl $B-A$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 190" font-family="sans-serif"><line x1="20" y1="120" x2="668" y2="120" stroke="#000" stroke-width="2"/><polygon points="668,120 657,114 657,126" fill="#000"/><line x1="44" y1="111" x2="44" y2="129" stroke="#000" stroke-width="2"/><line x1="104" y1="111" x2="104" y2="129" stroke="#000" stroke-width="2"/><line x1="164" y1="111" x2="164" y2="129" stroke="#000" stroke-width="2"/><line x1="224" y1="111" x2="224" y2="129" stroke="#000" stroke-width="2"/><line x1="284" y1="111" x2="284" y2="129" stroke="#000" stroke-width="2"/><line x1="344" y1="111" x2="344" y2="129" stroke="#000" stroke-width="2"/><line x1="404" y1="111" x2="404" y2="129" stroke="#000" stroke-width="2"/><line x1="464" y1="111" x2="464" y2="129" stroke="#000" stroke-width="2"/><line x1="524" y1="111" x2="524" y2="129" stroke="#000" stroke-width="2"/><line x1="584" y1="111" x2="584" y2="129" stroke="#000" stroke-width="2"/><line x1="644" y1="111" x2="644" y2="129" stroke="#000" stroke-width="2"/><text x="44" y="102" font-size="20" text-anchor="middle" font-style="italic">C</text><text x="404" y="102" font-size="20" text-anchor="middle" font-style="italic">A</text><text x="584" y="102" font-size="20" text-anchor="middle" font-style="italic">B</text><text x="164" y="150" font-size="18" text-anchor="middle">1,4</text><text x="524" y="150" font-size="18" text-anchor="middle">5,6</text></svg>',
  'cisel-osa.svg',
  'Ciselna osa se stejne velkymi dilky, oznacene body C, 1,4, A, 5,6, B.',
  'Číselná osa (dílek $0{,}7$)',
  new List<String>{'Mezi $1{,}4$ a $5{,}6$ je 6 dílků, takže jeden dílek je $\\frac{5{,}6-1{,}4}{6}=0{,}7$.','3.1 $C$ leží 2 dílky vlevo od $1{,}4$: $C=1{,}4-2\\cdot 0{,}7=0$.','3.2 $B=1{,}4+7\\cdot 0{,}7=6{,}3$; $6{,}3:1{,}4=4{,}5$.','3.3 $A=1{,}4+4\\cdot 0{,}7=4{,}2$; $B-A=6{,}3-4{,}2=2{,}1$.'},
  '3.1: $C=0$; 3.2: $4{,}5$krát; 3.3: $B-A=2{,}1$',
  3, 4, '2',
  new List<String>{'zs2','r7','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
