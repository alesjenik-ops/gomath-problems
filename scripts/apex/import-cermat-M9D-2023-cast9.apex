String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)';
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
  'CERMAT 2023 M9D · úloha 16',
  new List<String>{'Obrazce tvaru trojúhelníku se sestavují skládáním šedých trojúhelníků do pater (viz obrázek). Šedé trojúhelníky mají ve vrcholech puntíky a na stranách stejně dlouhé úsečky. V prvním obrazci je jeden šedý trojúhelník a každý další obrazec má o jedno patro více. Tabulka: patra $1/2/3$, šedé trojúhelníky $1/3/6$, puntíky $3/6/10$, úsečky $3/9/18$.','16.1 Určete počet úseček v obrazci, který má $5$ pater.','16.2 Počet úseček v posledním a předposledním obrazci se liší o $96$. Určete, o kolik se liší počet puntíků v těchto obrazcích.','16.3 V jednom obrazci je $300$ puntíků. Určete počet úseček v následujícím obrazci.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 288 103"><path d="M7 66L24 36L41 66L7 66Z" style="fill:#d9d9d9"/><path d="M21 36C21 35 22 33 24 33C25 33 27 35 27 36C27 38 25 39 24 39C22 39 21 38 21 36Z" style="fill:#000000"/><path d="M4 66C4 64 5 63 7 63C8 63 10 64 10 66C10 68 8 69 7 69C5 69 4 68 4 66Z" style="fill:#000000"/><path d="M38 66C38 64 39 63 41 63C42 63 44 64 44 66C44 68 42 69 41 69C39 69 38 68 38 66Z" style="fill:#000000"/><path d="M21 41L10 61M27 41L38 61M12 66L35 66M89 27L78 46M95 27L106 46M81 51L103 51M72 56L61 76M78 56L89 76M64 81L86 81M106 56L95 76M112 56L123 76M98 81L120 81M191 12L180 32M197 12L208 32M183 36L205 36M174 41L163 61M180 41L191 61M166 66L188 66M208 41L197 61M214 41L225 61M200 66L222 66M157 71L146 91M163 71L174 91M149 96L171 96M191 71L180 91M197 71L208 91M183 96L205 96M225 71L214 91M231 71L242 91M217 96L239 96" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M75 51L92 22L109 51L75 51Z" style="fill:#d9d9d9"/><path d="M58 81L75 51L92 81L58 81Z" style="fill:#d9d9d9"/><path d="M92 81L109 51L126 81L92 81Z" style="fill:#d9d9d9"/><path d="M89 22C89 20 90 19 92 19C94 19 95 20 95 22C95 23 94 24 92 24C90 24 89 23 89 22Z" style="fill:#000000"/><path d="M72 51C72 50 73 48 75 48C77 48 78 50 78 51C78 53 77 54 75 54C73 54 72 53 72 51Z" style="fill:#000000"/><path d="M106 51C106 50 107 48 109 48C111 48 112 50 112 51C112 53 111 54 109 54C107 54 106 53 106 51Z" style="fill:#000000"/><path d="M55 81C55 79 56 78 58 78C59 78 61 79 61 81C61 82 59 84 58 84C56 84 55 82 55 81Z" style="fill:#000000"/><path d="M89 81C89 79 90 78 92 78C93 78 95 79 95 81C95 82 93 84 92 84C90 84 89 82 89 81Z" style="fill:#000000"/><path d="M123 81C123 79 124 78 126 78C127 78 129 79 129 81C129 82 127 84 126 84C124 84 123 82 123 81Z" style="fill:#000000"/><path d="M177 36L194 7L211 36L177 36Z" style="fill:#d9d9d9"/><path d="M160 66L177 36L194 66L160 66Z" style="fill:#d9d9d9"/><path d="M194 66L211 36L228 66L194 66Z" style="fill:#d9d9d9"/><path d="M143 96L160 66L177 96L143 96Z" style="fill:#d9d9d9"/><path d="M177 96L194 66L211 96L177 96Z" style="fill:#d9d9d9"/><path d="M211 96L228 66L245 96L211 96Z" style="fill:#d9d9d9"/><path d="M191 7C191 5 193 4 194 4C196 4 197 5 197 7C197 8 196 10 194 10C193 10 191 8 191 7Z" style="fill:#000000"/><path d="M174 36C174 35 176 34 177 34C179 34 180 35 180 36C180 38 179 39 177 39C176 39 174 38 174 36Z" style="fill:#000000"/><path d="M208 36C208 35 210 34 211 34C213 34 214 35 214 36C214 38 213 39 211 39C210 39 208 38 208 36Z" style="fill:#000000"/><path d="M157 66C157 64 158 63 160 63C162 63 163 64 163 66C163 68 162 69 160 69C158 69 157 68 157 66Z" style="fill:#000000"/><path d="M191 66C191 64 192 63 194 63C196 63 197 64 197 66C197 68 196 69 194 69C192 69 191 68 191 66Z" style="fill:#000000"/><path d="M225 66C225 64 226 63 228 63C230 63 231 64 231 66C231 68 230 69 228 69C226 69 225 68 225 66Z" style="fill:#000000"/><path d="M140 96C140 94 141 93 143 93C144 93 146 94 146 96C146 97 144 99 143 99C141 99 140 97 140 96Z" style="fill:#000000"/><path d="M174 96C174 94 175 93 177 93C179 93 180 94 180 96C180 97 179 99 177 99C175 99 174 97 174 96Z" style="fill:#000000"/><path d="M208 96C208 94 209 93 211 93C213 93 214 94 214 96C214 97 213 99 211 99C209 99 208 97 208 96Z" style="fill:#000000"/><path d="M242 96C242 94 243 93 245 93C247 93 248 94 248 96C248 97 247 99 245 99C243 99 242 97 242 96Z" style="fill:#000000"/><text x="278" y="58" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text></svg>',
  'obr.svg',
  'Posloupnost trojúhelníkových obrazců skládaných z šedých trojúhelníků do pater (1., 2. a 3. obrazec) s puntíky ve vrcholech.',
  '',
  new List<String>{'Pro $n$ pater: úsečky $=3\\cdot\\frac{n(n+1)}{2}$, puntíky $=\\frac{(n+1)(n+2)}{2}$.','16.1: $3\\cdot\\frac{5\\cdot6}{2}=3\\cdot15=45$ úseček.','16.2: rozdíl úseček $=3n=96\\Rightarrow n=32$; rozdíl puntíků $=n+1=33$.','16.3: $\\frac{(n+1)(n+2)}{2}=300\\Rightarrow(n+1)(n+2)=600=24\\cdot25\\Rightarrow n=23$; následující obrazec má $24$ pater: úsečky $=3\\cdot\\frac{24\\cdot25}{2}=900$.'},
  '16.1: $45$ úseček; 16.2: o $33$ puntíků; 16.3: $900$ úseček',
  4, 6, '4',
  new List<String>{'zs2','r9','posloupnosti','algebra','vypocet','slovni','bez-kalkulacky'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
