String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)';
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
  'CERMAT 2026 M9D · úloha 13',
  new List<String>{'Děti se měly rozdělit do stejně početných skupin. Při dělení do trojic jedno dítě zbylo, při dělení do pětic nikdo nezbyl. Počet vytvořených pětic byl o $9$ menší než počet trojic.','Kolik pětic děti vytvořily?'},
  new List<String>{'A) $11$ pětic','B) $12$ pětic','C) $13$ pětic','D) $14$ pětic','E) jiný počet pětic'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je $p$ pětic, dětí je $5p$. Trojic je $\\frac{5p-1}{3}$ a platí $\\frac{5p-1}{3}=p+9$.','$5p-1=3p+27\\Rightarrow 2p=28\\Rightarrow p=14$ (dětí $70$; $70=3\\cdot23+1$).'},
  'D) $14$ pětic',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','modelovani','bez-kalkulacky','bez-kontextu'},
  'M9PDD26C0T04', 2026
);
c.add(
  'CERMAT 2026 M9D · úloha 14',
  new List<String>{'Na obrázku je síť hranolu, který má podstavy tvaru kosočtverce a boční stěny tvaru čtverce. Obsah jedné podstavy je $15\\ \\mathrm{cm}^2$. Součet délek všech hran hranolu je $60\\ \\mathrm{cm}$.','Jaký je objem hranolu?'},
  new List<String>{'A) $60\\ \\mathrm{cm}^3$','B) $75\\ \\mathrm{cm}^3$','C) $90\\ \\mathrm{cm}^3$','D) $105\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 122"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 55L466 55Z" style="fill:#000000"/><path d="M466 55L467 55L467 75L466 75Z" style="fill:#000000"/><path d="M466 75L467 75L467 91L466 91Z" style="fill:#000000"/><path d="M466 91L467 91L467 118L466 118Z" style="fill:#000000"/><path d="M402 110L364 84L319 84L356 110L402 110M319 39L356 13L402 13L364 39L319 39M273 39L455 39L455 84L273 84ZM319 84L364 84M319 39L364 39M364 39L364 84M409 39L409 84" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M319 39L364 39L364 84L319 84Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:2"/></svg>',
  'obr.svg',
  'Síť hranolu s podstavami tvaru kosočtverce a bočními stěnami tvaru čtverce.',
  '',
  new List<String>{'Boční stěny jsou čtverce, proto výška hranolu $=$ straně kosočtverce $a$. Hranol má $8$ hran podstav a $4$ boční hrany, všechny délky $a$: $12a=60\\Rightarrow a=5\\ \\mathrm{cm}$.','Objem $=$ obsah podstavy $\\times$ výška $=15\\cdot5=75\\ \\mathrm{cm}^3$.'},
  'B) $75\\ \\mathrm{cm}^3$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
