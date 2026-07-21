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
  'CERMAT 2023 M9B · úloha 9',
  new List<String>{'V rovině leží úsečka $AB$ a bod $S$. Úsečka $AB$ je základna rovnoramenného lichoběžníku $ABCD$; bod $S$ je střed ramene $AD$ (viz obrázek).','Sestrojte vrcholy $C$, $D$ lichoběžníku $ABCD$, označte je a lichoběžník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 502 337"><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M5 4L467 4L467 5L5 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M4 5L5 5L5 24L4 24Z" style="fill:#000000"/><path d="M467 5L468 5L468 24L467 24Z" style="fill:#000000"/><path d="M4 272L5 272L5 273L4 273Z" style="fill:#000000"/><path d="M4 272L5 272L5 273L4 273Z" style="fill:#000000"/><path d="M5 272L467 272L467 273L5 273Z" style="fill:#000000"/><path d="M467 272L468 272L468 273L467 273Z" style="fill:#000000"/><path d="M467 272L468 272L468 273L467 273Z" style="fill:#000000"/><path d="M4 24L5 24L5 272L4 272Z" style="fill:#000000"/><path d="M467 24L468 24L468 272L467 272Z" style="fill:#000000"/><path d="M89 227L382 171M96 230L94 221M375 176L373 168M130 155L124 149M130 149L124 155" style="fill:none;stroke:#000000;stroke-width:2"/><text x="59" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží úsečka</text><text x="115" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AB</text><text x="139" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a bod</text><text x="158" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="164" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="11" y="287" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">(</text><text x="22" y="287" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">CZVV</text><text x="35" y="287" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">)</text><text x="432" y="301" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">max. 2 body</text><text x="13" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">9</text><text x="64" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Úsečka</text><text x="89" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AB</text><text x="126" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je základna</text><text x="203" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rovnoramenného</text><text x="285" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">lichoběžníku</text><text x="333" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABCD</text><text x="351" y="315" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="56" y="331" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Bod</text><text x="70" y="331" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="114" y="331" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je střed ramene</text><text x="163" y="331" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AD</text><text x="225" y="331" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">tohoto lichoběžníku.</text><text x="96" y="245" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="376" y="191" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="137" y="158" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text></svg>',
  'obr.svg',
  'Úsečka AB a bod S v rovině.',
  '',
  new List<String>{'Rovnoramenný lichoběžník má osu souměrnosti kolmou na $AB$ v jeho středu. Vrchol $D$ leží na polopřímce $AS$ tak, že $S$ je střed $AD$, tedy $D$ je obraz $A$ ve středové souměrnosti podle $S$.','Vrchol $C$ je obraz $D$ v osové souměrnosti podle osy úsečky $AB$.'},
  'Vrchol $D$ je obraz $A$ podle středu $S$; vrchol $C$ je obraz $D$ v osové souměrnosti podle osy $AB$ (rovnoramenný lichoběžník).',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PBD23C0T02', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
