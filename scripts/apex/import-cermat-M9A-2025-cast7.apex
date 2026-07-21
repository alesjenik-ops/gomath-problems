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
  'CERMAT 2025 M9A · úloha 11',
  new List<String>{'Základní kvádr má délky hran $1\\ \\mathrm{cm}$, $2\\ \\mathrm{cm}$ a $3\\ \\mathrm{cm}$. Každé z těles bylo slepeno ze dvou základních kvádrů; čtyřboké hranoly jsou $M$, $N$ a další tělesa $P$, $Q$, $R$ (viz obrázek).','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','11.1 Součet délek všech hran jednoho základního kvádru je $24\\ \\mathrm{cm}$.','11.2 Povrchy hranolů $M$ a $N$ se liší o $6\\ \\mathrm{cm}^2$.','11.3 Všechna tři tělesa $P$, $Q$, $R$ mají stejný povrch.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 653 177"><path d="M4 4L5 4L5 46L4 46Z" style="fill:#000000"/><path d="M467 4L468 4L468 46L467 46Z" style="fill:#000000"/><path d="M4 46L5 46L5 65L4 65Z" style="fill:#000000"/><path d="M467 46L468 46L468 65L467 65Z" style="fill:#000000"/><path d="M4 65L5 65L5 81L4 81Z" style="fill:#000000"/><path d="M467 65L468 65L468 81L467 81Z" style="fill:#000000"/><path d="M4 81L5 81L5 173L4 173Z" style="fill:#000000"/><path d="M467 81L468 81L468 173L467 173Z" style="fill:#000000"/><path d="M305 42L310 37L310 8L305 13L305 42Z" style="fill:#d9d9d9"/><path d="M263 13L305 13L305 42L263 42Z" style="fill:#f2f2f2;stroke:#000000;stroke-width:2"/><path d="M305 42L310 37M211 152L211 109M211 109L196 109M187 119L196 109M201 119L211 109M187 162L187 119M201 147L201 119M201 119L187 119M331 123L331 109M331 109L303 109M288 124L303 109M316 124L331 109" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M201 162L211 152L211 109L201 119L201 162Z" style="fill:#d9d9d9"/><path d="M187 119L196 109L211 109L201 119L187 119Z" style="fill:#f2f2f2"/><path d="M187 119L201 119L201 162L187 162Z" style="fill:#f2f2f2"/><path d="M303 109L331 109L331 123L303 123Z" style="fill:none;stroke:#ffc000;stroke-width:1"/><path d="M316 138L331 123L331 109L316 124L316 138Z" style="fill:#d9d9d9"/><path d="M288 124L303 109L331 109L316 124L288 124Z" style="fill:#f2f2f2"/><text x="180" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Každé z následujících těles bylo slepeno ze dvou základních kvádrů.</text><text x="199" y="78" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Čtyřboké hranoly jsou označeny písmeny M, N a další tělesa písmeny P, Q, R.</text><text x="49" y="104" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="122" y="104" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">N</text><text x="221" y="104" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">P</text><text x="305" y="104" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Q</text><text x="401" y="104" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text></svg>',
  'obr.svg',
  'Základní kvádr 1×2×3 cm a tělesa M, N, P, Q, R slepená vždy ze dvou základních kvádrů.',
  '',
  new List<String>{'11.1: součet hran kvádru $4\\cdot(1+2+3)=24\\ \\mathrm{cm}$ — A.','11.2: povrchy hranolů $M$ a $N$ (slepené různými stěnami) se liší o $6\\ \\mathrm{cm}^2$ — A.','11.3: tělesa $P$, $Q$, $R$ mají stejný povrch — A.'},
  '11.1: A; 11.2: A; 11.3: A',
  4, 5, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD25C0T01', 2025
);
c.add(
  'CERMAT 2025 M9A · úloha 12',
  new List<String>{'Bazén má délku $40\\ \\mathrm{m}$ a šířku $10\\ \\mathrm{m}$. V celé zóně pro neplavce (délka $20\\ \\mathrm{m}$) je hloubka $1\\ \\mathrm{m}$. Zóna pro plavce (délka $20\\ \\mathrm{m}$) má šikmé dno a hloubka se zvětšuje z $1\\ \\mathrm{m}$ na $2\\ \\mathrm{m}$ (viz obrázek).','Jaký je objem bazénu?'},
  new List<String>{'A) $500\\ \\mathrm{m}^3$','B) $550\\ \\mathrm{m}^3$','C) $600\\ \\mathrm{m}^3$','D) $650\\ \\mathrm{m}^3$','E) jiný objem'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 772 91"><path d="M7 4L463 4L463 5L7 5Z" style="fill:#000000"/><path d="M4 36L466 36L466 37L4 37Z" style="fill:#000000"/><text x="113" y="30" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">VÝCHOZÍ TEXT A OBRÁZEK K ÚLOZE 12</text><text x="234" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Bazén má délku 40 metrů a šířku 10 metrů. Hloubka bazénu není všude stejná (viz obrázek).</text><text x="235" y="70" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V celé zóně pro neplavce je hloubka 1 m. Zóna pro plavce má šikmé dno a hloubka bazénu</text><text x="100" y="85" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">se v ní postupně zvětší z 1 m na 2 m.</text></svg>',
  'obr.svg',
  'Podélný řez bazénu délky 40 m: zóna pro neplavce hloubka 1 m a zóna pro plavce se šikmým dnem od 1 m do 2 m.',
  '',
  new List<String>{'Zóna pro neplavce: $20\\cdot10\\cdot1=200\\ \\mathrm{m}^3$.','Zóna pro plavce (průměrná hloubka $1{,}5\\ \\mathrm{m}$): $20\\cdot10\\cdot1{,}5=300\\ \\mathrm{m}^3$.','Celkem $200+300=500\\ \\mathrm{m}^3$.'},
  'A) $500\\ \\mathrm{m}^3$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
