String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2025 M9A · úloha 5',
  new List<String>{'Na obrázku je plánek pozemku tvaru čtverce s délkou strany $c=30\\ \\mathrm{m}$. Světle šedý obdélník je půdorys domu, tmavší obrazec je rybníček. Půdorys domu má pětkrát menší obsah, než je celková rozloha pozemku.','5.1 Délka domu $a$ je rovna polovině délky strany pozemku $c$. Určete šířku domu $b$.','5.2 Rozloha rybníčku je $18\\ \\%$ celkové rozlohy pozemku. Vypočtěte v $\\mathrm{m}^2$ rozlohu volné části pozemku, na níž není ani dům, ani rybníček.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 176"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 58L466 58Z" style="fill:#000000"/><path d="M466 58L467 58L467 74L466 74Z" style="fill:#000000"/><path d="M466 74L467 74L467 90L466 90Z" style="fill:#000000"/><path d="M466 90L467 90L467 109L466 109Z" style="fill:#000000"/><path d="M466 109L467 109L467 125L466 125Z" style="fill:#000000"/><path d="M466 125L467 125L467 144L466 144Z" style="fill:#000000"/><path d="M466 144L467 144L467 172L466 172Z" style="fill:#000000"/><path d="M307 14L443 14L443 150L307 150Z" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M313 19L373 19L373 87L313 87Z" style="fill:#f2f2f2;stroke:#000000;stroke-width:2"/><path d="M373 128C387 109 432 109 417 95C401 81 436 66 438 121C438 129 434 140 414 143C393 145 359 147 373 128Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><text x="451" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑐</text><text x="380" y="59" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑎</text><text x="343" y="101" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑏</text></svg>',
  'obr.svg',
  'Plánek čtvercového pozemku o straně 30 m se světle šedým obdélníkovým půdorysem domu (délka a, šířka b) a tmavším rybníčkem.',
  '',
  new List<String>{'Rozloha pozemku $30^2=900\\ \\mathrm{m}^2$; půdorys domu $\\frac{900}{5}=180\\ \\mathrm{m}^2$.','5.1: $a=\\frac{c}{2}=15\\ \\mathrm{m}$, tedy $b=\\frac{180}{15}=12\\ \\mathrm{m}$.','5.2: rybníček $0{,}18\\cdot900=162\\ \\mathrm{m}^2$; volná část $900-180-162=558\\ \\mathrm{m}^2$.'},
  '5.1: $b=12\\ \\mathrm{m}$; 5.2: $558\\ \\mathrm{m}^2$',
  4, 6, '3',
  new List<String>{'zs2','r9','procenta','geometrie','slovni','modelovani','s-kalkulackou','bezny-zivot'},
  'M9PAD25C0T01', 2025
);
c.add(
  'CERMAT 2025 M9A · úloha 6',
  new List<String>{'Zahradní sud má tvar rotačního válce. Dno sudu má obsah $1\\,500\\ \\mathrm{cm}^2$.','6.1 Při dešti stoupla hladina vody v sudu o $10\\ \\mathrm{mm}$. Vypočtěte, kolik litrů vody přibylo v sudu.','6.2 Při silném lijáku přibyly v sudu $3$ litry vody. Vypočtěte, o kolik mm stoupla hladina vody.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: $10\\ \\mathrm{mm}=1\\ \\mathrm{cm}$; objem $1\\,500\\cdot1=1\\,500\\ \\mathrm{cm}^3=1{,}5$ litru.','6.2: $3$ litry $=3\\,000\\ \\mathrm{cm}^3$; výška $\\frac{3\\,000}{1\\,500}=2\\ \\mathrm{cm}=20\\ \\mathrm{mm}$.'},
  '6.1: $1{,}5$ litru; 6.2: $20\\ \\mathrm{mm}$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
