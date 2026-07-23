String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD25C0T03';
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
  'CERMAT M9C 2025 – úloha 12',
  new List<String>{'Na hřišti je podle plánku vymezen uzavřený okruh, v němž na sebe navazuje $5$ rovných úseků. Některé sousední úseky jsou na sebe kolmé (viz obrázek). Jirka prošel celý okruh stejně dlouhými kroky a do plánku si zaznamenal jejich počet na prvních čtyřech úsecích.','Kolika kroky prošel Jirka poslední úsek okruhu?'},
  new List<String>{'A) méně než $85$ kroky','B) $85$ kroky','C) $90$ kroky','D) $95$ kroky','E) $100$ kroky'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 340" font-family="sans-serif"> <polygon points="40,20 130,20 130,125 280,125 40,305" fill="none" stroke="#000" stroke-width="2"/> <polyline points="52,20 52,32 40,32" fill="none" stroke="#000"/> <polyline points="118,20 118,32 130,32" fill="none" stroke="#000"/> <polyline points="130,113 142,113 142,125" fill="none" stroke="#000"/> <text x="85" y="14" font-size="14" text-anchor="middle">30</text> <text x="140" y="78" font-size="14">35</text> <text x="205" y="118" font-size="14" text-anchor="middle">50</text> <text x="188" y="222" font-size="14">100</text> <text x="26" y="168" font-size="16" font-style="italic">?</text> </svg>',
  'okruh.svg',
  'Uzavřený pětiúhelníkový okruh s úseky 30, 35, 50, diagonálou 100 a neznámým posledním úsekem; tři pravé úhly.',
  'Plánek okruhu (počty kroků na úsecích)',
  new List<String>{'Vodorovná vzdálenost mezi konci diagonálního úseku je $30+50=80$ kroků. Diagonální úsek měří $100$ kroků, jeho svislá složka je proto $\\sqrt{100^2-80^2}=\\sqrt{3600}=60$ kroků. Poslední (svislý) úsek okruh uzavře, jeho délka je $35+60=95$ kroků.'},
  'D) $95$ kroky',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2025 – úloha 13',
  new List<String>{'Na každé stěně krychle je vždy jedna úhlopříčka celá přelepena pěti shodnými šedými čtverci tak, že sousední čtverce mají právě jeden společný vrchol (viz obrázek). Nepolepená část každé stěny je bílá. Součet obsahů všech bílých nepolepených ploch na povrchu krychle je $480$ cm².','Jakou délku má hrana krychle?'},
  new List<String>{'A) méně než $10$ cm','B) $10$ cm','C) $12$ cm','D) $15$ cm','E) $20$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif"> <polygon points="150,60 310,60 310,220 150,220" fill="#fff" stroke="#000" stroke-width="2"/> <polygon points="150,60 210,20 370,20 310,60" fill="#fff" stroke="#000" stroke-width="2"/> <polygon points="310,60 370,20 370,180 310,220" fill="#fff" stroke="#000" stroke-width="2"/> <rect x="150" y="60" width="32" height="32" fill="#b9b9b9" stroke="#000"/> <rect x="182" y="92" width="32" height="32" fill="#b9b9b9" stroke="#000"/> <rect x="214" y="124" width="32" height="32" fill="#b9b9b9" stroke="#000"/> <rect x="246" y="156" width="32" height="32" fill="#b9b9b9" stroke="#000"/> <rect x="278" y="188" width="32" height="32" fill="#b9b9b9" stroke="#000"/> <text x="210" y="248" font-size="12" text-anchor="middle">schematicky nakres (sede ctverce na kazde stene)</text> </svg>',
  'krychle.svg',
  'Krychle, na přední stěně pět šedých čtverců rozmístěných po úhlopříčce jako schodiště.',
  'Schematický nákres krychle',
  new List<String>{'Pět šedých čtverců na úhlopříčce dělí stěnu jako políčka sítě $5\\times 5$; každý má stranu $\\frac{a}{5}$. Šedá plocha jedné stěny je $5\\cdot\\left(\\frac{a}{5}\\right)^2=\\frac{a^2}{5}$, bílá plocha stěny je $a^2-\\frac{a^2}{5}=\\frac{4}{5}a^2$. Na $6$ stěnách je bílé plochy $6\\cdot\\frac{4}{5}a^2=\\frac{24}{5}a^2=480$, odtud $a^2=100$ a $a=10$ cm.'},
  'B) $10$ cm',
  2, 5, '4',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
