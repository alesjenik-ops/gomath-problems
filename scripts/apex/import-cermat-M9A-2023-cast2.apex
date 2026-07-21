String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 1. řádný termín (M9A)';
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
  'CERMAT 2023 M9A · úloha 6',
  new List<String>{'Pravoúhlý lichoběžník $ABCD$ se základnami $AB$, $CD$ má pravý úhel při vrcholu $C$. Z obrázku: $CD=10\\ \\mathrm{cm}$, $AB=6\\ \\mathrm{cm}$, boční strana $BC=8\\ \\mathrm{cm}$ (viz obrázek).','6.1 Vypočtěte v $\\mathrm{cm}^2$ obsah trojúhelníku $ABD$.','6.2 Vypočtěte v $\\mathrm{cm}^2$ obsah lichoběžníku $ABCD$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 142"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 59L466 59Z" style="fill:#000000"/><path d="M466 59L467 59L467 77L466 77Z" style="fill:#000000"/><path d="M466 77L467 77L467 96L466 96Z" style="fill:#000000"/><path d="M466 96L467 96L467 115L466 115Z" style="fill:#000000"/><path d="M4 137L466 137L466 138L4 138Z" style="fill:#000000"/><path d="M466 137L467 137L467 138L466 138Z" style="fill:#000000"/><path d="M466 137L467 137L467 138L466 138Z" style="fill:#000000"/><path d="M466 115L467 115L467 137L466 137Z" style="fill:#000000"/><path d="M425 111L425 30L323 30L364 111ZM323 30L425 111" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M425 45C416 45 410 38 410 30" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M417 36C417 35 418 35 419 35C419 35 420 35 420 36C420 37 419 37 419 37C418 37 417 37 417 36Z" style="fill:#000000"/><text x="240" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="249" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">CD</text><text x="362" y="126" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="430" y="126" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="430" y="27" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="320" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="396" y="126" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text><text x="442" y="77" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="375" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10 cm</text></svg>',
  'obr.svg',
  'Pravoúhlý lichoběžník ABCD se základnami AB=6 cm, CD=10 cm a boční stranou BC=8 cm; pravý úhel při vrcholu C.',
  '',
  new List<String>{'Výška lichoběžníku je $BC=8\\ \\mathrm{cm}$.','6.1: trojúhelník $ABD$ má základnu $AB=6$ a výšku $8$; $S=\\frac{6\\cdot8}{2}=24\\ \\mathrm{cm}^2$.','6.2: $S=\\frac{6+10}{2}\\cdot8=64\\ \\mathrm{cm}^2$.'},
  '6.1: $24\\ \\mathrm{cm}^2$; 6.2: $64\\ \\mathrm{cm}^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 7',
  new List<String>{'Pro žáky 8. a 9. tříd byly otevřeny tři kroužky (hudební, šachový, robotický); každý žák je nejvýše v jednom. V grafu jsou počty žáků (jeden údaj a čísla na svislé ose chybí). V hudebním je o $6$ žáků méně než v šachovém. Ve všech třech kroužcích dohromady je poměr počtu žáků 8. tříd ku počtu žáků 9. tříd $2:3$.','7.1 Určete, o kolik procent více je v hudebním kroužku žáků 8. tříd než žáků 9. tříd.','7.2 Určete, kolik žáků 9. tříd je v šachovém kroužku.','7.3 Určete, jaký je v robotickém kroužku poměr počtu žáků 8. tříd ku počtu žáků 9. tříd.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Z grafu a podmínek (hudební o $6$ méně než šachový; celkový poměr $2:3$) se dopočtou chybějící hodnoty.','7.1: v hudebním kroužku je žáků 8. tříd o $25\\ \\%$ více než žáků 9. tříd.','7.2: žáků 9. tříd v šachovém kroužku je $21$.','7.3: v robotickém kroužku je poměr $3:7$.'},
  '7.1: o $25\\ \\%$; 7.2: $21$ žáků; 7.3: $3:7$',
  3, 5, '4',
  new List<String>{'zs2','r9','statistika','procenta','argumentace','bez-kalkulacky','bezny-zivot'},
  'M9PAD23C0T01', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
