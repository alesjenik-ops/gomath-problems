String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 1. řádný termín (M9A)';
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
  'CERMAT 2021 M9A · úloha 13',
  new List<String>{'Pravoúhlý lichoběžník ABCD je úsečkou DP délky $12\\ \\mathrm{cm}$ rozdělen na čtverec PBCD a trojúhelník APD (viz obrázek). Obsah trojúhelníku APD je $6$krát menší než obsah čtverce PBCD. Z lichoběžníku ABCD oddělíme šedý trojúhelník ABC.','Jaký je obvod šedého trojúhelníku ABC?'},
  new List<String>{'A) menší než $48\\ \\mathrm{cm}$','B) $48\\ \\mathrm{cm}$','C) $50\\ \\mathrm{cm}$','D) $52\\ \\mathrm{cm}$','E) větší než $52\\ \\mathrm{cm}$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 391 135"><path d="M149 15L149 114L7 114L50 15ZM50 15L50 114M376 15L376 114L234 114L276 15Z" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M376 114L376 15L234 114L376 114Z" style="fill:#d9d9d9"/><path d="M376 15L234 114" style="fill:none;stroke:#000000;stroke-width:1"/><text x="7" y="128" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="155" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="156" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="48" y="13" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="52" y="128" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">P</text><text x="233" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="381" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="381" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="274" y="13" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Pravoúhlý lichoběžník ABCD rozdělený úsečkou DP na čtverec PBCD a trojúhelník APD; vpravo tentýž lichoběžník se šedě vyznačeným trojúhelníkem ABC.',
  '',
  new List<String>{'Strana čtverce PBCD je $DP=12\\ \\mathrm{cm}$, jeho obsah $=12^2=144\\ \\mathrm{cm}^2$; obsah trojúhelníku APD $=144:6=24\\ \\mathrm{cm}^2$.','Trojúhelník APD je pravoúhlý s odvěsnami AP a $PD=12$: $\\frac{1}{2}\\cdot AP\\cdot12=24\\Rightarrow AP=4\\ \\mathrm{cm}$.','V trojúhelníku ABC je $AB=AP+PB=4+12=16\\ \\mathrm{cm}$, $BC=12\\ \\mathrm{cm}$ a přepona $AC=\\sqrt{16^2+12^2}=\\sqrt{400}=20\\ \\mathrm{cm}$.','Obvod $=16+12+20=48\\ \\mathrm{cm}$.'},
  'B) $48\\ \\mathrm{cm}$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','vyber','bez-kalkulacky'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 14',
  new List<String>{'Všechny rodiny z Jižní a Severní ulice uvedly, kolik chovají psů. Výsledky jsou v tabulce (některá pole nejsou vyplněna).','Jižní ulice: počet všech rodin $48$; rodin s $0$ psy $33$; s $1$ psem (chybí); se $2$ psy $5$; se $3$ psy (chybí); aritmetický průměr počtu chovaných psů $0{,}5$.','Severní ulice: počet všech rodin (chybí); rodin s $0$ psy $23$; s $1$ psem $12$; se $2$ psy $1$; se $3$ psy (chybí).','Právě $3$ psy chová v Severní ulici dvakrát více rodin než v Jižní ulici. Kolik rodin bydlí v Severní ulici?'},
  new List<String>{'A) $40$','B) $42$','C) $44$','D) $46$','E) jiný počet'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Jižní ulice: celkový počet psů $=0{,}5\\cdot48=24$. Označme počet rodin s $1$ psem $a$ a se $3$ psy $b$: $33+a+5+b=48\\Rightarrow a+b=10$ a $a+2\\cdot5+3b=24\\Rightarrow a+3b=14$.','Odečtením: $2b=4\\Rightarrow b=2$, tedy v Jižní ulici chovají $3$ psy $2$ rodiny.','V Severní ulici chovají $3$ psy $2\\cdot2=4$ rodiny. Počet rodin v Severní ulici $=23+12+1+4=40$.'},
  'A) $40$',
  2, 4, '4',
  new List<String>{'zs2','r9','aritmetika','prumer','uvazovani','slovni','vyber','bez-kalkulacky','bezny-zivot'},
  'M9PAD21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
