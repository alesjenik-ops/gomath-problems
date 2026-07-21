String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. řádný termín (M9B)';
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
  'CERMAT 2025 M9B · úloha 10',
  new List<String>{'V rovině leží body $A$, $D$, $M$ (viz obrázek).','Body $A$, $D$ jsou vrcholy rovnoběžníku $ABCD$. Na polopřímce $DM$ leží jedna z úhlopříček rovnoběžníku. Druhá úhlopříčka má stejnou délku jako úsečka $DM$.','Sestrojte vrcholy $B$, $C$ rovnoběžníku $ABCD$, označte je a rovnoběžník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 318"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M467 4L468 4L468 23L467 23Z" style="fill:#000000"/><path d="M4 23L5 23L5 314L4 314Z" style="fill:#000000"/><path d="M467 23L468 23L468 314L467 314Z" style="fill:#000000"/><path d="M182 274L176 279M182 279L176 274M100 254L94 259M100 259L94 254M285 123L279 129M285 129L279 123" style="fill:none;stroke:#000000;stroke-width:2"/><text x="55" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="110" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="123" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="130" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="137" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="179" y="294" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="97" y="274" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="282" y="143" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text></svg>',
  'obr.svg',
  'Body A, D, M v rovině.',
  '',
  new List<String>{'Úhlopříčky rovnoběžníku se půlí; jejich průsečík $S$ je střed obou úhlopříček. Úhlopříčka $DB$ leží na polopřímce $DM$.','Druhá úhlopříčka $AC$ má délku $|DM|$, takže $|AS|=\\frac{|DM|}{2}$; bod $C$ je obraz $A$ podle středu $S$.','Střed $S$ leží na polopřímce $DM$ tak, aby $|AS|=\\frac{|DM|}{2}$; pak $B$ je obraz $D$ podle $S$ a $C$ obraz $A$ podle $S$.'},
  'Průsečík úhlopříček $S$ leží na polopřímce $DM$ s $|AS|=\\tfrac{|DM|}{2}$; $B$ je obraz $D$ a $C$ obraz $A$ ve středové souměrnosti podle $S$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PBD25C0T02', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
