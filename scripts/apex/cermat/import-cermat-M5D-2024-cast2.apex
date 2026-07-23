String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD24C0T04';
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
  'CERMAT M5D 2024 – úloha 4.2',
  new List<String>{'Řešte slovní úlohu. Jana měla čokoládu, kterou lze rozdělit na $32$ stejných dílků. Rozdělila se o ni s Petrem a Kamilem a celou ji snědli. Tři osminy čokolády snědl Petr. Jana snědla o třetinu méně dílků než Petr.','Kolik dílků čokolády snědl Kamil?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Petr snědl $\\frac{3}{8}\\cdot 32=12$ dílků. Jana snědla o třetinu méně: $12-\\frac{1}{3}\\cdot 12=12-4=8$ dílků. Kamil snědl zbytek: $32-12-8=12$ dílků.'},
  '$12$ dílků',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2024 – úloha 4.3',
  new List<String>{'Řešte slovní úlohu. Jaký je součet tří čísel, je-li první číslo $82$, druhé číslo je o $7$ menší než první a třetí číslo je součtem prvního a druhého?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Druhé číslo: $82-7=75$. Třetí číslo: $82+75=157$. Součet: $82+75+157=314$.'},
  '$314$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 5.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost: $\\frac{1}{3}$ hodiny $-\\frac{1}{6}$ hodiny $=$ ____ sekund.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{3}$ hodiny $=1\\,200$ s, $\\frac{1}{6}$ hodiny $=600$ s. Rozdíl je $1\\,200-600=600$ sekund.'},
  '$600$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 5.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost: $1$ metr $-\\frac{1}{4}$ metru $=$ ____ centimetrů $+\\,250$ milimetrů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ m $-\\frac{1}{4}$ m $=\\frac{3}{4}$ m $=75$ cm. Protože $250$ mm $=25$ cm, do rámečku patří $75-25=50$ centimetrů.'},
  '$50$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 6',
  new List<String>{'Pruh papíru byl rozstříhán na $10$ stejných dílků. Rozstříhané dílky byly nalepeny na papír podle obrázku tak, že vymezily obdélník. Delší strana obdélníku je dlouhá $51$ cm.','6.1 Kolik cm měří kratší strana vymezeného obdélníku?','6.2 Kolik cm měřil pruh papíru před rozstříháním?'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 235" font-family="sans-serif"><rect x="25" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="52" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="79" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="106" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="133" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="160" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="187" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="214" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="241" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><rect x="268" y="22" width="27" height="14" fill="#c9c9c9" stroke="#000"/><text x="160" y="16" font-size="11" text-anchor="middle">pruh: 10 stejnych dilku</text><rect x="75" y="75" width="50" height="18" fill="#c9c9c9" stroke="#000"/><rect x="75" y="193" width="50" height="18" fill="#c9c9c9" stroke="#000"/><rect x="125" y="75" width="50" height="18" fill="#c9c9c9" stroke="#000"/><rect x="125" y="193" width="50" height="18" fill="#c9c9c9" stroke="#000"/><rect x="175" y="75" width="50" height="18" fill="#c9c9c9" stroke="#000"/><rect x="175" y="193" width="50" height="18" fill="#c9c9c9" stroke="#000"/><rect x="75" y="93" width="18" height="50" fill="#c9c9c9" stroke="#000"/><rect x="207" y="93" width="18" height="50" fill="#c9c9c9" stroke="#000"/><rect x="75" y="143" width="18" height="50" fill="#c9c9c9" stroke="#000"/><rect x="207" y="143" width="18" height="50" fill="#c9c9c9" stroke="#000"/><text x="150.0" y="69" font-size="11" text-anchor="middle">delsi strana = 51 cm</text></svg>',
  'pruh-obdelnik.svg',
  'Pruh papíru rozstříhaný na deset stejných dílků a obdélník vymezený těmito dílky (nahoře a dole po třech, po stranách po dvou).',
  'Výchozí obrázek k úloze 6 (schematický nákres)',
  new List<String>{'Delší stranu tvoří $3$ dílky, jeden dílek tedy měří $51:3=17$ cm.','6.1 Kratší stranu tvoří $2$ dílky: $2\\cdot 17=34$ cm.','6.2 Pruh měl $10$ dílků: $10\\cdot 17=170$ cm.'},
  '6.1: $34$ cm; 6.2: $170$ cm',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
