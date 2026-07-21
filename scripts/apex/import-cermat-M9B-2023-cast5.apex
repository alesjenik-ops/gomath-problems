String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 2. řádný termín (M9B)';
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
  'CERMAT 2023 M9B · úloha 13',
  new List<String>{'Trojboký hranol leží na jedné boční stěně. Podstavu tvoří rovnoramenný trojúhelník se základnou $24\\ \\mathrm{cm}$ a obsahem $60\\ \\mathrm{cm}^2$. Výška $v$ na základnu tohoto trojúhelníku je stejná jako délka nejkratší hrany hranolu (viz obrázek).','Jaký je objem trojbokého hranolu?'},
  new List<String>{'A) $150\\ \\mathrm{cm}^3$','B) $200\\ \\mathrm{cm}^3$','C) $300\\ \\mathrm{cm}^3$','D) $370\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 98"><path d="M466 4L467 4L467 23L466 23Z" style="fill:#000000"/><path d="M466 23L467 23L467 42L466 42Z" style="fill:#000000"/><path d="M466 42L467 42L467 58L466 58Z" style="fill:#000000"/><path d="M466 58L467 58L467 74L466 74Z" style="fill:#000000"/><path d="M4 93L466 93L466 94L4 94Z" style="fill:#000000"/><path d="M466 93L467 93L467 94L466 94Z" style="fill:#000000"/><path d="M466 93L467 93L467 94L466 94Z" style="fill:#000000"/><path d="M466 74L467 74L467 93L466 93Z" style="fill:#000000"/><path d="M307 54L449 54M449 54L378 14M307 54L378 14M293 68L364 28L435 68L293 68M435 68L449 54M364 28L378 14M293 68L307 54" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M364 28L364 68" style="fill:none;stroke:#000000;stroke-width:1"/><text x="239" y="50" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="245" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="366" y="83" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">24 cm</text><text x="371" y="51" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑣</text><text x="450" y="69" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑣</text></svg>',
  'obr.svg',
  'Trojboký hranol s podstavou tvaru rovnoramenného trojúhelníku (základna 24 cm) a vyznačenou výškou v.',
  '',
  new List<String>{'Výška na základnu: $\\frac{24\\cdot v}{2}=60\\Rightarrow v=5\\ \\mathrm{cm}$; nejkratší hrana (délka hranolu) je také $5\\ \\mathrm{cm}$.','Objem $=$ obsah podstavy $\\times$ délka $=60\\cdot5=300\\ \\mathrm{cm}^3$.'},
  'C) $300\\ \\mathrm{cm}^3$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 14',
  new List<String>{'Košíkář prodal během prvních dvou dnů trhů všechny upletené pomlázky. První den prodal pětinu všech, druhý den o $180$ pomlázek více než první den.','Kolik pomlázek prodal košíkář první den?'},
  new List<String>{'A) $60$ pomlázek','B) $45$ pomlázek','C) $36$ pomlázek','D) $30$ pomlázek','E) jiný počet pomlázek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je všech $N$ pomlázek: první den $\\frac{N}{5}$, druhý $\\frac{N}{5}+180$; $\\frac{N}{5}+\\frac{N}{5}+180=N\\Rightarrow \\frac{3N}{5}=180\\Rightarrow N=300$.','První den $\\frac{300}{5}=60$ pomlázek.'},
  'A) $60$ pomlázek',
  2, 4, '3',
  new List<String>{'zs2','r9','zlomky','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Skautský oddíl má letos $60$ členů, což je o $20$ členů více než loni. O kolik procent má letos více členů než loni?','15.2 Jakub utratil tři pětiny kapesného; tři čtvrtiny této utracené částky použil na turistickou známku. Kolik procent kapesného utratil za známku?','15.3 První a druhý den festivalu se prodal stejný počet vstupenek; třetí den o třetinu více než druhý den. Kolik procent všech vstupenek se prodalo třetí den?'},
  new List<String>{'A) méně než $40\\ \\%$','B) $40\\ \\%$','C) $45\\ \\%$','D) $50\\ \\%$','E) $55\\ \\%$','F) více než $55\\ \\%$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $\\frac{20}{40}=50\\ \\%$ — D.','15.2: $\\frac{3}{4}\\cdot\\frac{3}{5}=\\frac{9}{20}=45\\ \\%$ — C.','15.3: den $1=$ den $2=x$, den $3=\\frac{4}{3}x$; podíl $\\frac{\\frac{4}{3}x}{\\frac{10}{3}x}=\\frac{4}{10}=40\\ \\%$ — B.'},
  '15.1: D ($50\\ \\%$); 15.2: C ($45\\ \\%$); 15.3: B ($40\\ \\%$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','zlomky','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD23C0T02', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
