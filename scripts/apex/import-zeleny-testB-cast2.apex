String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený B6 – sekáči a žací lišta',
  new List<String>{'Časy se mění. Když se před $50$ lety kosila naše louka, nastoupilo $10$ sekáčů s kosišti a za $2$ dny měli hotovo. Makalo se pěkně zostra $10$ hodin denně. Dneska zavolám pana Bukáčka s „džondýrem" a žací lištou a je pokoseno za dvě hodiny. A za hodinu práce si vyúčtuje $1\\,200$ Kč.','6.1 Vypočtěte, o kolik Kč by bylo dražší pokosit louku „postaru", kdybych každému sekáči platil $100$ Kč za hodinu práce.','6.2 Vypočtěte, jak dlouho by trvalo posečení naší louky, kdyby ve stejný okamžik začalo louku kosit $20$ sekáčů i pan Bukáček s technikou. Výsledek uveďte v minutách.'},
  null,
  5,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Postaru: $10$ sekáčů pracovalo $2\\cdot 10=20$ hodin, tj. $10\\cdot 20\\cdot 100=20\\,000$ Kč. Pan Bukáček: $2\\cdot 1\\,200=2\\,400$ Kč. Rozdíl $20\\,000-2\\,400=17\\,600$ Kč.','6.2 Celá louka představuje $10\\cdot 20=200$ sekáč-hodin práce. $20$ sekáčů poseče za hodinu $\\frac{20}{200}=\\frac{1}{10}$ louky, pan Bukáček $\\frac{1}{2}$ louky. Spolu $\\frac{1}{10}+\\frac{1}{2}=\\frac{3}{5}$ louky za hodinu, tedy celá louka za $\\frac{5}{3}$ hodiny $=100$ minut.'},
  '6.1: o $17\\,600$ Kč; 6.2: $100$ minut',
  5, 8, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený B7.1 – tablety Celaskonu',
  new List<String>{'Kolik tablet Celaskonu lze vyrobit z $10$ kg vitaminu C, jestliže každá tableta obsahuje v průměru $200$ mg tohoto vitaminu?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$10$ kg $=10\\,000\\,000$ mg. Počet tablet $10\\,000\\,000:200=50\\,000$.'},
  '$50\\,000$ tablet',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený B7.2 – blesk a hrom',
  new List<String>{'Za kolik sekund po úderu blesku uslyšíme zadunění hromu, jestliže blesk uhodil do rozhledny vzdálené od nás vzdušnou čarou zhruba $4$ km a víme, že se zvuk šíří rychlostí $330$ m/s? Výsledek zaokrouhlete na celé sekundy.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4$ km $=4\\,000$ m. Čas $\\frac{4\\,000}{330}\\doteq 12{,}1$ s, po zaokrouhlení asi $12$ sekund.'},
  'asi za $12$ sekund',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','fyzika'}
);
c.add(
  'Zelený B7.3 – krychličky v krabici',
  new List<String>{'Jaký maximální počet kostek tvaru krychle o hraně $200$ mm se vejde do krabice tvaru krychle o hraně $1{,}2$ metru?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$200$ mm $=0{,}2$ m. Podél hrany se vejde $1{,}2:0{,}2=6$ kostek, celkem $6^3=216$ kostek.'},
  '$216$ kostek',
  1, 3, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B8 – lichoběžník se čtvercem',
  new List<String>{'Na obrázku vidíte rovnoramenný lichoběžník s ramenem o délce $5$ cm, do kterého je vepsán čtverec obsahu $16$ cm².','8.1 Vypočtěte obvod lichoběžníku.','8.2 Vypočtěte obsah lichoběžníku.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 270" font-family="sans-serif"> <polygon points="90,210 390,210 300,90 180,90" fill="none" stroke="#000" stroke-width="2.5"/> <rect x="180" y="90" width="120" height="120" fill="#dfe6da" stroke="#000" stroke-width="1.5"/> <text x="240" y="158" font-size="16" text-anchor="middle">P = 16 cm²</text> <text x="360" y="150" font-size="16">a = 5 cm</text> </svg>',
  'lichobeznik-ctverec.svg',
  'Rovnoramenný lichoběžník s ramenem 5 cm a vepsaným čtvercem o obsahu 16 cm².',
  'Rovnoramenný lichoběžník s vepsaným čtvercem',
  new List<String>{'8.1 Strana čtverce je $\\sqrt{16}=4$ cm, což je i výška lichoběžníku a jeho kratší základna. Vodorovný přesah ramene $\\sqrt{5^2-4^2}=3$ cm. Delší základna $4+3+3=10$ cm. Obvod $10+4+5+5=24$ cm.','8.2 Obsah $S=\\frac{10+4}{2}\\cdot 4=28$ cm².'},
  '8.1: $24$ cm; 8.2: $28$ cm²',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
