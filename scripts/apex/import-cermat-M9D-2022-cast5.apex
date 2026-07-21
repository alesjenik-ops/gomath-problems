String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, druhý náhradní termín (M9D)';
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
  'CERMAT 2022 M9D · úloha 11',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$ (viz obrázek). Každý z nich má pouze jednu osu souměrnosti.','V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (sestrojených svisle, vodorovně nebo šikmo).','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Správně upravený útvar $A$ má pouze $2$ osy souměrnosti.','11.2 Správně upravený útvar $B$ má pouze $2$ osy souměrnosti.','11.3 Správně upravený útvar $C$ má pouze $1$ osu souměrnosti.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 145"><path d="M4 140L466 140L466 141L4 141Z" style="fill:#000000"/><path d="M51 22L65 22L65 36L51 36Z" style="fill:#a6a6a6"/><path d="M65 22L79 22L79 36L65 36Z" style="fill:#a6a6a6"/><path d="M37 36L51 36L51 50L37 50Z" style="fill:#a6a6a6"/><path d="M79 36L93 36L93 50L79 50Z" style="fill:#a6a6a6"/><path d="M23 50L37 50L37 65L23 65Z" style="fill:#a6a6a6"/><path d="M37 50L51 50L51 65L37 65Z" style="fill:#a6a6a6"/><path d="M79 50L93 50L93 65L79 65Z" style="fill:#a6a6a6"/><path d="M93 50L108 50L108 65L93 65Z" style="fill:#a6a6a6"/><path d="M23 65L37 65L37 79L23 79Z" style="fill:#a6a6a6"/><path d="M51 65L65 65L65 79L51 79Z" style="fill:#a6a6a6"/><path d="M23 79L37 79L37 93L23 93Z" style="fill:#a6a6a6"/><path d="M37 79L51 79L51 93L37 93Z" style="fill:#a6a6a6"/><path d="M79 79L93 79L93 93L79 93Z" style="fill:#a6a6a6"/><path d="M93 79L108 79L108 93L93 93Z" style="fill:#a6a6a6"/><path d="M37 93L51 93L51 107L37 107Z" style="fill:#a6a6a6"/><path d="M79 93L93 93L93 107L79 107Z" style="fill:#a6a6a6"/><path d="M51 107L65 107L65 121L51 121Z" style="fill:#a6a6a6"/><path d="M65 107L79 107L79 121L65 121Z" style="fill:#a6a6a6"/><path d="M15 22L143 22M15 36L143 36M15 50L143 50M15 65L143 65M15 79L143 79M15 93L143 93M15 107L143 107M15 121L143 121M23 128L23 15M37 128L37 15M51 128L51 15M65 128L65 15M79 128L79 15M93 128L93 15M108 128L108 15M122 128L122 15M136 128L136 15M171 22L299 22M171 36L299 36M171 50L299 50M171 65L299 65M171 79L299 79M171 93L299 93M171 107L299 107M171 121L299 121M178 128L178 15M193 128L193 15M207 128L207 15M221 128L221 15M235 128L235 15M249 128L249 15M264 128L264 15M278 128L278 15M292 128L292 15M327 22L455 22M327 36L455 36M327 50L455 50M327 65L455 65M327 79L455 79M327 93L455 93M327 107L455 107M334 128L334 15M349 128L349 15M363 128L363 15M377 128L377 15M391 128L391 15M405 128L405 15M419 128L419 15M434 128L434 15M448 128L448 15M327 121L455 121" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M193 36L207 36L207 50L193 50Z" style="fill:#a6a6a6"/><path d="M207 36L221 36L221 50L207 50Z" style="fill:#a6a6a6"/><path d="M235 36L249 36L249 50L235 50Z" style="fill:#a6a6a6"/><path d="M249 36L264 36L264 50L249 50Z" style="fill:#a6a6a6"/><path d="M193 50L207 50L207 65L193 65Z" style="fill:#a6a6a6"/><path d="M221 50L235 50L235 65L221 65Z" style="fill:#a6a6a6"/><path d="M249 50L264 50L264 65L249 65Z" style="fill:#a6a6a6"/><path d="M178 65L193 65L193 79L178 79Z" style="fill:#a6a6a6"/><path d="M263 65L278 65L278 79L263 79Z" style="fill:#a6a6a6"/><path d="M193 79L207 79L207 93L193 93Z" style="fill:#a6a6a6"/><path d="M249 79L264 79L264 93L249 93Z" style="fill:#a6a6a6"/><path d="M193 93L207 93L207 107L193 107Z" style="fill:#a6a6a6"/><path d="M207 93L221 93L221 107L207 107Z" style="fill:#a6a6a6"/><path d="M235 93L249 93L249 107L235 107Z" style="fill:#a6a6a6"/><path d="M249 93L264 93L264 107L249 107Z" style="fill:#a6a6a6"/><path d="M221 107L235 107L235 121L221 121Z" style="fill:#a6a6a6"/><path d="M391 36L405 36L405 50L391 50Z" style="fill:#a6a6a6"/><path d="M363 50L377 50L377 65L363 65Z" style="fill:#a6a6a6"/><path d="M377 50L391 50L391 65L377 65Z" style="fill:#a6a6a6"/><path d="M363 65L377 65L377 79L363 79Z" style="fill:#a6a6a6"/><path d="M391 65L405 65L405 79L391 79Z" style="fill:#a6a6a6"/><path d="M419 65L434 65L434 79L419 79Z" style="fill:#a6a6a6"/><path d="M349 79L363 79L363 93L349 93Z" style="fill:#a6a6a6"/><path d="M377 79L391 79L391 93L377 93Z" style="fill:#a6a6a6"/><path d="M391 79L405 79L405 93L391 93Z" style="fill:#a6a6a6"/><path d="M405 79L420 79L420 93L405 93Z" style="fill:#a6a6a6"/><path d="M391 93L405 93L405 107L391 107Z" style="fill:#a6a6a6"/><path d="M377 107L391 107L391 121L377 121Z" style="fill:#a6a6a6"/><text x="81" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="237" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="393" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text></svg>',
  'obr.svg',
  'Tři útvary A, B, C složené z tmavých čtverečků ve čtvercové síti; každý má jednu osu souměrnosti.',
  '',
  new List<String>{'V každém útvaru přemístíme právě jeden tmavý čtvereček tak, aby výsledný útvar měl co nejvíce os souměrnosti.','11.1: útvar $A$ lze upravit tak, že má právě $2$ osy souměrnosti — tvrzení je pravdivé (A).','11.2: nejlépe upravený útvar $B$ má jiný počet os než právě $2$ (lze dosáhnout více os souměrnosti) — tvrzení je nepravdivé (N).','11.3: nejlépe upravený útvar $C$ má více než $1$ osu souměrnosti — tvrzení je nepravdivé (N).'},
  '11.1: A; 11.2: N; 11.3: N',
  4, 6, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','soumernost','uvazovani','bez-kalkulacky'},
  'M9PDD22C0T04', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
