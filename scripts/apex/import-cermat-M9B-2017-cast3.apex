String SRC   = 'CERMAT – Jednotná přijímací zkouška 2017, 2. řádný termín (M9B)';
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
  'CERMAT 2017 M9B · úloha 9',
  new List<String>{'V rovině leží trojúhelník $RST$ (viz obrázek).','Sestrojte obraz $R_1S_1T_1$ trojúhelníku $RST$ ve středové souměrnosti se středem $S$. Všechny vrcholy trojúhelníku $R_1S_1T_1$ označte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 279 116"><path d="M12 97L12 96L183 96L183 96L263 15L264 17L12 97M263 15C263 15 264 15 264 16C264 16 264 16 264 17L184 97C184 97 183 97 183 97L12 97C12 97 11 97 11 96C11 96 11 96 12 96Z" style="fill:#000000"/><text x="7" y="109" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text><text x="185" y="110" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="269" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">T</text></svg>',
  'obr.svg',
  'V rovině leží trojúhelník RST: vrchol R vlevo dole, S dole uprostřed, T vpravo nahoře.',
  '',
  new List<String>{'Ve středové souměrnosti se středem $S$ se bod $S$ zobrazí sám na sebe, tedy $S_1=S$. Obraz $R_1$ leží na polopřímce opačné k $SR$ tak, že $|SR_1|=|SR|$; obdobně $T_1$ leží na polopřímce opačné k $ST$ tak, že $|ST_1|=|ST|$. Body $R_1$, $S_1=S$, $T_1$ spojíme.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Obraz $R_1S_1T_1$ ve středové souměrnosti se středem $S$ (platí $S_1=S$; $R_1$ a $T_1$ jsou souměrně sdružené s $R$ a $T$ podle středu $S$).',
  2, 4, '3',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PBD17C0T02', 2017
);

System.debug('Vytvořeno úloh: '+c.created);
