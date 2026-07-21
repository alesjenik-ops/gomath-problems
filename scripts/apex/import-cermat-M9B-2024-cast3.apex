String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. řádný termín (M9B)';
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
  'CERMAT 2024 M9B · úloha 8',
  new List<String>{'Obrazce jsou tvořeny z velkých bílých a malých tmavých kruhů. $1.$ obrazec tvoří $1$ bílý kruh; $2.$ obrazec $4$ bílé kruhy (středy tvoří vrcholy čtverce) a $1$ tmavý uprostřed; $3.$ obrazec $9$ bílých a $4$ tmavé kruhy atd. (viz obrázek).','8.1 Kolik velkých bílých kruhů obsahuje osmý obrazec?','8.2 Kolikátý obrazec obsahuje $361$ malých tmavých kruhů?'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 278"><path d="M4 272L455 272L455 274L4 274Z" style="fill:#000000"/><path d="M455 4L456 4L456 272L455 272Z" style="fill:#000000"/><path d="M455 272L456 272L456 274L455 274Z" style="fill:#000000"/><path d="M455 272L456 272L456 274L455 274Z" style="fill:#000000"/><path d="M49 206C49 196 58 188 68 188C78 188 86 196 86 206C86 216 78 225 68 225C58 225 49 216 49 206Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M136 187C136 177 144 169 155 169C165 169 173 177 173 187C173 198 165 206 155 206C144 206 136 198 136 187Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M136 224C136 214 144 206 155 206C165 206 173 214 173 224C173 234 165 243 155 243C144 243 136 234 136 224Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M173 187C173 177 181 169 191 169C202 169 210 177 210 187C210 198 202 206 191 206C181 206 173 198 173 187Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M173 225C173 215 182 207 192 207C202 207 210 215 210 225C210 235 202 243 192 243C182 243 173 235 173 225Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M165 206C165 202 169 198 173 198C177 198 180 202 180 206C180 210 177 213 173 213C169 213 165 210 165 206Z" style="fill:#7f7f7f;stroke:#000000;stroke-width:2"/><path d="M249 166C249 156 257 148 268 148C278 148 286 156 286 166C286 176 278 185 268 185C257 185 249 176 249 166Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M249 204C249 194 258 185 268 185C278 185 286 194 286 204C286 214 278 222 268 222C258 222 249 214 249 204Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M286 166C286 156 294 148 304 148C315 148 323 156 323 166C323 176 315 185 304 185C294 185 286 176 286 166Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M286 204C286 194 294 186 304 186C315 186 323 194 323 204C323 214 315 222 304 222C294 222 286 214 286 204Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M278 185C278 180 282 177 286 177C290 177 293 180 293 185C293 189 290 192 286 192C282 192 278 189 278 185Z" style="fill:#7f7f7f;stroke:#000000;stroke-width:2"/><path d="M249 240C249 230 257 222 268 222C278 222 286 230 286 240C286 251 278 259 268 259C257 259 249 251 249 240Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M286 240C286 230 294 222 304 222C315 222 323 230 323 240C323 251 315 259 304 259C294 259 286 251 286 240Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M324 167C324 157 332 148 342 148C352 148 360 157 360 167C360 177 352 185 342 185C332 185 324 177 324 167Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M324 204C324 193 332 185 342 185C352 185 360 193 360 204C360 214 352 222 342 222C332 222 324 214 324 204Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M324 240C324 230 332 222 342 222C352 222 360 230 360 240C360 251 352 259 342 259C332 259 324 251 324 240Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M315 185C315 180 319 177 323 177C327 177 330 180 330 185C330 189 327 192 323 192C319 192 315 189 315 185Z" style="fill:#7f7f7f;stroke:#000000;stroke-width:2"/><path d="M279 222C279 218 282 215 286 215C290 215 294 218 294 222C294 227 290 230 286 230C282 230 279 227 279 222Z" style="fill:#7f7f7f;stroke:#000000;stroke-width:2"/><path d="M315 222C315 218 319 215 323 215C327 215 330 218 330 222C330 227 327 230 323 230C319 230 315 227 315 222Z" style="fill:#7f7f7f;stroke:#000000;stroke-width:2"/></svg>',
  'obr.svg',
  'Posloupnost obrazců z velkých bílých a malých tmavých kruhů (1., 2. a 3. obrazec).',
  '',
  new List<String>{'$n$-tý obrazec má $n^2$ bílých a $(n-1)^2$ tmavých kruhů.','8.1: $8^2=64$ bílých kruhů.','8.2: $(n-1)^2=361\\Rightarrow n-1=19\\Rightarrow n=20$, tedy $20.$ obrazec.'},
  '8.1: $64$; 8.2: $20.$ obrazec',
  4, 5, '4',
  new List<String>{'zs2','r9','posloupnosti','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD24C0T02', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
